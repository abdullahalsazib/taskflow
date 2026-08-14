import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/core/theme/app_color.dart';
import 'package:task_flow/core/theme/theme_provider.dart';
import 'package:task_flow/features/tasks/presentation/widgets/buttons/dialog_icon.dart';

void showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogIcon(icon: Icons.dashboard_customize_rounded),

              const SizedBox(height: 12),

              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary(context),
                ),
              ),

              const SizedBox(height: 20),

              _settingsItem(
                context: context,
                icon: Icons.palette_outlined,
                title: "Appearance",
                onTap: () {
                  Navigator.pop(context);

                  showAppearanceDialog(context);
                },
              ),

              _settingsItem(
                context: context,
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                onTap: () {
                  Navigator.pop(context);
                  showNotificationSettings(context);
                },
              ),

              _settingsItem(
                context: context,
                icon: Icons.info_outline_rounded,
                title: "About",
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(context);
                },
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: AppColors.brandPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _settingsItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary(context)),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          Icon(
            Icons.chevron_right_rounded,
            size: 19,
            color: AppColors.textMuted(context),
          ),
        ],
      ),
    ),
  );
}

void showNotificationSettings(BuildContext context) {
  bool pushNotification = true;
  bool dailyReminder = true;
  bool soundEffects = false;

  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: AppColors.brandGradient,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DialogIcon(icon: Icons.dashboard_customize_rounded),

                  const SizedBox(height: 12),

                  const Text(
                    "Notification Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _switchItem(
                    title: "Push Notifications",
                    value: pushNotification,
                    onChanged: (value) {
                      setState(() {
                        pushNotification = value;
                      });
                    },
                  ),

                  _switchItem(
                    title: "Daily Reminders",
                    value: dailyReminder,
                    onChanged: (value) {
                      setState(() {
                        dailyReminder = value;
                      });
                    },
                  ),

                  _switchItem(
                    title: "Sound Effects",
                    value: soundEffects,
                    onChanged: (value) {
                      setState(() {
                        soundEffects = value;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Close"),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withAlpha(35),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _switchItem({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontSize: 11, color: Colors.white),
        ),
      ),

      Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: AppColors.brandPrimary,
      ),
    ],
  );
}

void showAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 15),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogIcon(icon: Icons.info_rounded),

              const SizedBox(height: 12),

              Text(
                "About TaskFlow",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary(context),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "TaskFlow v1.0.0 — a productivity dashboard "
                "built with Flutter and powered by the "
                "provider package for beautiful, maintainable "
                "task management.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.45,
                  color: AppColors.textMuted(context),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Got it"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showAppearanceDialog(BuildContext context) {
  AppThemeMode selectedTheme = context.read<ThemeProvider>().selectedMode;

  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  DialogIcon(icon: Icons.dashboard_customize_rounded),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    "Choose Appearance",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary(context),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Light Mode
                  _themeOption(
                    context: context,
                    title: "Light Mode",
                    icon: Icons.light_mode_outlined,
                    selected: selectedTheme == AppThemeMode.light,
                    onTap: () {
                      setState(() {
                        selectedTheme = AppThemeMode.light;
                      });
                    },
                  ),

                  const SizedBox(height: 7),

                  // Dark Mode
                  _themeOption(
                    context: context,
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    selected: selectedTheme == AppThemeMode.dark,
                    onTap: () {
                      setState(() {
                        selectedTheme = AppThemeMode.dark;
                      });
                    },
                  ),

                  const SizedBox(height: 7),

                  // System Default
                  _themeOption(
                    context: context,
                    title: "System Default",
                    icon: Icons.settings_suggest_outlined,
                    selected: selectedTheme == AppThemeMode.system,
                    onTap: () {
                      setState(() {
                        selectedTheme = AppThemeMode.system;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: AppColors.brandPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.read<ThemeProvider>().setThemeMode(
                              selectedTheme,
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _themeOption({
  required BuildContext context,
  required String title,
  required IconData icon,
  required bool selected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.optionSelectedBackground(context)
            : AppColors.optionBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : AppColors.borderSoft(context),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.textSecondary(context)),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          if (selected)
            Icon(
              Icons.check_circle,
              size: 15,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    ),
  );
}
