import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/core/theme/app_color.dart';
import 'package:task_flow/core/theme/theme_provider.dart';
import 'package:task_flow/features/tasks/presentation/pages/home_screen.dart';
import 'package:task_flow/features/tasks/presentation/providers/notification_settings_provider.dart';
import 'package:task_flow/features/tasks/presentation/providers/todo_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('TaskFlow HomeScreen renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => NotificationSettingsProvider()),
        ],
        child: MaterialApp(
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          home: const HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify header and main UI elements are displayed
    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.text('Add Task'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
