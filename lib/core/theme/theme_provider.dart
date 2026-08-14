import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadThemeMode();
  }

  static const String _themeModeKey = 'app_theme_mode';

  AppThemeMode _selectedMode = AppThemeMode.system;

  AppThemeMode get selectedMode => _selectedMode;

  ThemeMode get themeMode {
    switch (_selectedMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_selectedMode == mode) {
      return;
    }

    _selectedMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.name);
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_themeModeKey);

    if (saved == null) {
      return;
    }

    final match = AppThemeMode.values.where((mode) => mode.name == saved);
    if (match.isNotEmpty) {
      _selectedMode = match.first;
      notifyListeners();
    }
  }
}
