import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/login_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/settings_screen.dart';
import '../services/storage_service.dart';
import 'app_logo.dart';

/// Side menu opened with the hamburger icon on the home screen.
class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  void _open(BuildContext context, Widget screen) {
    final navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Center(child: AppLogo(size: 40))),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile & Favorites'),
            onTap: () => _open(context, const FavoritesScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _open(context, const SettingsScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => _open(context, const NotificationsScreen()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              final navigator = Navigator.of(context);
              await StorageService.instance.logout();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
