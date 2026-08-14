import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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

  // Delays for notifications (30s for pending task alert, 60s for task reminder).
  static const Duration _uncompletedDelay = Duration(seconds: 30);
  static const Duration _dailyDelay = Duration(seconds: 60);

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    await _configureLocalTimeZone();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentAlert: true,
      defaultPresentSound: true,
      defaultPresentBadge: true,
      defaultPresentBanner: true,
      defaultPresentList: true,
    );
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
        linux: linuxSettings,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Notification action / tap callback
      },
    );

    await _createAndroidChannels();
    _isInitialized = true;
  }

  Future<void> _configureLocalTimeZone() async {
    tz_data.initializeTimeZones();
    try {
      final dynamic tzInfo = await FlutterTimezone.getLocalTimezone();
      final String timeZoneName = tzInfo is String ? tzInfo : (tzInfo.name ?? tzInfo.identifier ?? tzInfo.toString());
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      try {
        tz.setLocalLocation(tz.getLocation('UTC'));
      } catch (_) {}
    }
  }

  Future<void> requestPermissions() async {
    await initialize();

    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await android?.requestNotificationsPermission();
      await android?.requestExactAlarmsPermission();
    } else if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      await ios?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isMacOS) {
      final macOS = _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >();
      await macOS?.requestPermissions(alert: true, badge: true, sound: true);
    }
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

  Future<void> showTestNotification() async {
    await initialize();
    final settings = await _readSettings();

    final androidDetails = AndroidNotificationDetails(
      _channelIdFor(useDailySound: true, soundEnabled: settings.soundEnabled),
      'Daily reminders',
      channelDescription: 'Reminder notifications for tasks',
      importance: Importance.max,
      priority: Priority.high,
      playSound: settings.soundEnabled,
      sound: settings.soundEnabled
          ? const RawResourceAndroidNotificationSound('sound1')
          : null,
    );

    final darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: settings.soundEnabled,
      presentBanner: true,
      presentList: true,
      sound: settings.soundEnabled ? 'sound1.wav' : null,
    );

    await _plugin.show(
      0,
      'TaskFlow Notification Test',
      'Notifications and sounds are configured successfully!',
      NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
        macOS: darwinDetails,
      ),
      payload: 'test_notification',
    );
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
        body: '"${todo.title}" is still pending. Reminder after 30 seconds.',
        delay: _uncompletedDelay,
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
        body: 'Reminder after 60 seconds for "${todo.title}".',
        delay: _dailyDelay,
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
          ? 'Reminder notifications for tasks after 60 seconds'
          : 'Notifications for uncompleted tasks after 30 seconds',
      importance: Importance.max,
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
      presentBanner: true,
      presentList: true,
      sound: soundEnabled
          ? (useDailySound ? 'sound1.wav' : 'sound2.mp3')
          : null,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduledAt,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'task_reminder',
      );
    } catch (_) {
      try {
        await _plugin.zonedSchedule(
          id,
          title,
          body,
          scheduledAt,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'task_reminder',
        );
      } catch (_) {}
    }
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
        description: 'Alerts for uncompleted tasks after 30 seconds',
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('sound2'),
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _uncompletedSilentChannelId,
        'Uncompleted task reminders (silent)',
        description: 'Silent alerts for uncompleted tasks after 30 seconds',
        importance: Importance.high,
        playSound: false,
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _dailySoundChannelId,
        'Daily reminders (sound)',
        description: 'Alerts for task reminders after 60 seconds',
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('sound1'),
      ),
    );

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _dailySilentChannelId,
        'Daily reminders (silent)',
        description: 'Silent alerts for task reminders after 60 seconds',
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
