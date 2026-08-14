import 'package:flutter/material.dart';
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogIcon(icon: Icons.dashboard_customize_rounded),

              const SizedBox(height: 12),

              const Text(
                "Settings",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 20),

              _settingsItem(
                icon: Icons.palette_outlined,
                title: "Appearance",
                onTap: () {
                  Navigator.pop(context);

                  showAppearanceDialog(context);
                },
              ),

              _settingsItem(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                onTap: () {
                  Navigator.pop(context);
                  showNotificationSettings(context);
                },
              ),

              _settingsItem(
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
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Color(0xFF6663A4),
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
          Icon(icon, size: 18, color: const Color(0xFF5B5870)),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),

          const Icon(
            Icons.chevron_right_rounded,
            size: 19,
            color: Color(0xFF9A98A3),
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
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6254E7), Color(0xFF27C7DD)],
                ),
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
        activeTrackColor: const Color(0xFF6254E7),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogIcon(icon: Icons.info_rounded),

              const SizedBox(height: 12),

              const Text(
                "About TaskFlow",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 10),

              const Text(
                "TaskFlow v1.0.0 — a productivity dashboard "
                "built with Flutter and powered by the "
                "provider package for beautiful, maintainable "
                "task management.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.45,
                  color: Color(0xFF8D8A95),
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
                    backgroundColor: const Color(0xFF347FE5),
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
  String selectedTheme = "Light Mode";

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
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  DialogIcon(icon: Icons.dashboard_customize_rounded),

                  const SizedBox(height: 12),

                  // Title
                  const Text(
                    "Choose Appearance",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF20202A),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Light Mode
                  _themeOption(
                    title: "Light Mode",
                    icon: Icons.light_mode_outlined,
                    selected: selectedTheme == "Light Mode",
                    onTap: () {
                      setState(() {
                        selectedTheme = "Light Mode";
                      });
                    },
                  ),

                  const SizedBox(height: 7),

                  // Dark Mode
                  _themeOption(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    selected: selectedTheme == "Dark Mode",
                    onTap: () {
                      setState(() {
                        selectedTheme = "Dark Mode";
                      });
                    },
                  ),

                  const SizedBox(height: 7),

                  // System Default
                  _themeOption(
                    title: "System Default",
                    icon: Icons.settings_suggest_outlined,
                    selected: selectedTheme == "System Default",
                    onTap: () {
                      setState(() {
                        selectedTheme = "System Default";
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
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Color(0xFF665DA7),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // এখানে পরে ThemeProvider
                            // ব্যবহার করবে।

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5D4BE8),
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
        color: selected ? const Color(0xFFF0ECFA) : const Color(0xFFFAF9FC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selected ? const Color(0xFF7165A8) : const Color(0xFFF0EEF4),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: const Color(0xFF66636F)),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF33313A),
              ),
            ),
          ),

          if (selected)
            const Icon(Icons.check_circle, size: 15, color: Color(0xFF4F477D)),
        ],
      ),
    ),
  );
}
