import 'package:flutter/material.dart';
import 'package:task_flow/core/notifications/notification_service.dart';
import 'package:task_flow/features/tasks/data/models/todo_model.dart';

class NotificationSettingsProvider extends ChangeNotifier {
  NotificationSettingsProvider() {
    _load();
  }

  bool _pushNotificationsEnabled = true;
  bool _dailyReminderEnabled = true;
  bool _soundEffectsEnabled = true;

  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get dailyReminderEnabled => _dailyReminderEnabled;
  bool get soundEffectsEnabled => _soundEffectsEnabled;

  Future<void> _load() async {
    _pushNotificationsEnabled = await NotificationService.instance
        .getPushNotificationsEnabled();
    _dailyReminderEnabled = await NotificationService.instance
        .getDailyReminderEnabled();
    _soundEffectsEnabled = await NotificationService.instance
        .getSoundEffectsEnabled();
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    await NotificationService.instance.requestPermissions();
  }

  Future<void> sendTestNotification() async {
    await NotificationService.instance.requestPermissions();
    await NotificationService.instance.showTestNotification();
  }

  Future<void> setPushNotificationsEnabled(
    bool value,
    List<TodoModel> todos,
  ) async {
    _pushNotificationsEnabled = value;
    notifyListeners();

    await NotificationService.instance.setPushNotificationsEnabled(value);
    if (value) {
      await NotificationService.instance.requestPermissions();
    }
    await NotificationService.instance.syncForTodos(todos);
  }

  Future<void> setDailyReminderEnabled(
    bool value,
    List<TodoModel> todos,
  ) async {
    _dailyReminderEnabled = value;
    notifyListeners();

    await NotificationService.instance.setDailyReminderEnabled(value);
    if (value) {
      await NotificationService.instance.requestPermissions();
    }
    await NotificationService.instance.syncForTodos(todos);
  }

  Future<void> setSoundEffectsEnabled(bool value, List<TodoModel> todos) async {
    _soundEffectsEnabled = value;
    notifyListeners();

    await NotificationService.instance.setSoundEffectsEnabled(value);
    await NotificationService.instance.syncForTodos(todos);
  }
}
