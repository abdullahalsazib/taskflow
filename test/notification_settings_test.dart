import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/core/notifications/notification_service.dart';
import 'package:task_flow/features/tasks/data/models/todo_model.dart';
import 'package:task_flow/features/tasks/presentation/providers/notification_settings_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (MethodCall methodCall) async => true,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_timezone'),
      (MethodCall methodCall) async => 'UTC',
    );
    SharedPreferences.setMockInitialValues({
      NotificationService.pushEnabledKey: true,
      NotificationService.dailyReminderEnabledKey: true,
      NotificationService.soundEffectsEnabledKey: false,
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      null,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_timezone'),
      null,
    );
  });

  test('NotificationSettingsProvider loads settings and updates state', () async {
    final provider = NotificationSettingsProvider();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(provider.pushNotificationsEnabled, isTrue);
    expect(provider.dailyReminderEnabled, isTrue);
    expect(provider.soundEffectsEnabled, isFalse);

    final todos = [
      TodoModel(
        id: 'task-1',
        title: 'Complete Project',
        description: 'Finish notification setup',
        priority: 'High',
      ),
    ];

    await provider.setSoundEffectsEnabled(true, todos);
    expect(provider.soundEffectsEnabled, isTrue);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(NotificationService.soundEffectsEnabledKey), isTrue);
  });
}
