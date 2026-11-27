import 'package:flutter/material.dart';

import '../main.dart';
import '../services/storage_service.dart';
import 'notifications_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(storage.username),
            subtitle: Text(storage.currentUser ?? ''),
          ),
          const Divider(),
          ValueListenableBuilder<bool>(
            valueListenable: darkMode,
            builder: (_, value, __) => SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark mode'),
              value: value,
              onChanged: (v) async {
                darkMode.value = v;
                await storage.setDarkMode(v);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('SmakBook 1.0.0 • Data: TheMealDB'),
          ),
        ],
      ),
    );
  }
}
