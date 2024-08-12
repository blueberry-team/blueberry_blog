import 'package:blueberry_flutter_template/core/OssLicenseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'provider/NotificationProvider.dart';
import '../../core/provider/ThemeProvider.dart';

class SettingScreen extends ConsumerWidget {
  static const String name = 'SettingsScreen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        title: const Text('Setting'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Notification'),
                const SizedBox(width: 20),
                const Icon(Icons.notifications),
                Switch.adaptive(
                  value: ref.watch(notificationProvider),
                  onChanged:
                      ref.read(notificationProvider.notifier).setNotification,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Change Password'),
            ),
            const Divider(height: 60),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Policy'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Contact us'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OssLicenseScreen(),
                  ),
                );
              },
              child: const Text('Open source page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text('Account delete'),
            ),
            const SizedBox(height: 40),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (bool value) {
                themeNotifier.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
