import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/features/tasks/data/models/todo_model.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const String pushEnabledKey = 'push_notifications_enabled';
  static const String dailyReminderEnabledKey = 'daily_reminder_enabled';
  static const String soundEffectsEnabledKey = 'sound_effects_enabled';

  static const String _uncompletedSoundChannelId =
      'task_uncompleted_reminder_sound';
  static const String _uncompletedSilentChannelId =
      'task_uncompleted_reminder_silent';
  static const String _dailySoundChannelId = 'task_daily_reminder_sound';
  static const String _dailySilentChannelId = 'task_daily_reminder_silent';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );

    await _createAndroidChannels();
    _isInitialized = true;
  }

  Future<void> requestPermissions() async {
    await initialize();

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<bool> getPushNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(pushEnabledKey) ?? true;
  }

  Future<bool> getDailyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dailyReminderEnabledKey) ?? true;
  }

  Future<bool> getSoundEffectsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(soundEffectsEnabledKey) ?? true;
  }

  Future<void> setPushNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(pushEnabledKey, value);
  }

  Future<void> setDailyReminderEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(dailyReminderEnabledKey, value);
  }

  Future<void> setSoundEffectsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(soundEffectsEnabledKey, value);
  }

  Future<void> scheduleForNewTask(TodoModel todo) async {
    await initialize();
    await _syncSingleTodo(todo);
  }

  Future<void> syncForTodos(List<TodoModel> todos) async {
    await initialize();

    for (final todo in todos) {
      await _syncSingleTodo(todo);
    }
  }

  Future<void> cancelForTask(String taskId) async {
    await initialize();
    await _plugin.cancel(_uncompletedNotificationId(taskId));
    await _plugin.cancel(_dailyNotificationId(taskId));
  }

  Future<void> _syncSingleTodo(TodoModel todo) async {
    final settings = await _readSettings();

    if (todo.isCompleted) {
      await cancelForTask(todo.id);
      return;
    }

    if (settings.pushEnabled) {
      await _scheduleNotification(
        id: _uncompletedNotificationId(todo.id),
        title: 'Task still uncompleted',
        body: '"${todo.title}" is still pending. Check it after 3 hours.',
        delay: const Duration(hours: 3),
        useDailySound: false,
        soundEnabled: settings.soundEnabled,
      );
    } else {
      await _plugin.cancel(_uncompletedNotificationId(todo.id));
    }

    if (settings.dailyEnabled) {
      await _scheduleNotification(
        id: _dailyNotificationId(todo.id),
        title: 'Task reminder',
        body: 'Reminder after 12 hours for "${todo.title}".',
        delay: const Duration(hours: 12),
        useDailySound: true,
        soundEnabled: settings.soundEnabled,
      );
    } else {
      await _plugin.cancel(_dailyNotificationId(todo.id));
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required Duration delay,
    required bool useDailySound,
    required bool soundEnabled,
  }) async {
    final scheduledAt = tz.TZDateTime.now(tz.local).add(delay);

    final androidDetails = AndroidNotificationDetails(
      _channelIdFor(useDailySound: useDailySound, soundEnabled: soundEnabled),
      useDailySound ? 'Daily reminders' : 'Uncompleted task reminders',
      channelDescription: useDailySound
          ? 'Reminder notifications for tasks after 12 hours'
          : 'Notifications for uncompleted tasks after 3 hours',
      importance: Importance.high,
      priority: Priority.high,
      playSound: soundEnabled,
      sound: soundEnabled
          ? RawResourceAndroidNotificationSound(
              useDailySound ? 'sound1' : 'sound2',
            )
          : null,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: soundEnabled,
      sound: soundEnabled
          ? (useDailySound ? 'sound1.wav' : 'sound2.mp3')
          : null,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledAt,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'task_reminder',
    );
  }

  String _channelIdFor({
    required bool useDailySound,
    required bool soundEnabled,
  }) {
    if (useDailySound) {
      return soundEnabled ? _dailySoundChannelId : _dailySilentChannelId;
    }

    return soundEnabled
        ? _uncompletedSoundChannelId
        : _uncompletedSilentChannelId;
  }

  Future<void> _createAndroidChannels() async {
    if (!Platform.isAndroid) {
      return;
    }

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (android == null) {
      return;
    }

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _uncompletedSoundChannelId,
        'Uncompleted task reminders (sound)',
        description: 'Alerts for uncompleted tasks after 3 hours',
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('sound2'),
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _uncompletedSilentChannelId,
        'Uncompleted task reminders (silent)',
        description: 'Silent alerts for uncompleted tasks after 3 hours',
        importance: Importance.high,
        playSound: false,
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _dailySoundChannelId,
        'Daily reminders (sound)',
        description: 'Alerts for task reminders after 12 hours',
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('sound1'),
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _dailySilentChannelId,
        'Daily reminders (silent)',
        description: 'Silent alerts for task reminders after 12 hours',
        importance: Importance.high,
        playSound: false,
      ),
    );
  }

  _NotificationSettings _readSettingsSync(SharedPreferences prefs) {
    return _NotificationSettings(
      pushEnabled: prefs.getBool(pushEnabledKey) ?? true,
      dailyEnabled: prefs.getBool(dailyReminderEnabledKey) ?? true,
      soundEnabled: prefs.getBool(soundEffectsEnabledKey) ?? true,
    );
  }

  Future<_NotificationSettings> _readSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return _readSettingsSync(prefs);
  }

  int _stableIdFromTask(String taskId) {
    var hash = 0;
    for (final codeUnit in taskId.codeUnits) {
      hash = ((hash * 31) + codeUnit) & 0x7fffffff;
    }
    return hash % 100000000;
  }

  int _uncompletedNotificationId(String taskId) {
    return (_stableIdFromTask(taskId) * 2) + 1;
  }

  int _dailyNotificationId(String taskId) {
    return (_stableIdFromTask(taskId) * 2) + 2;
  }
}

class _NotificationSettings {
  const _NotificationSettings({
    required this.pushEnabled,
    required this.dailyEnabled,
    required this.soundEnabled,
  });

  final bool pushEnabled;
  final bool dailyEnabled;
  final bool soundEnabled;
}
