import 'package:flutter/material.dart';

import '../services/notification_service.dart';
import '../services/storage_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _enabled = StorageService.instance.notificationsEnabled;

  Future<void> _toggle(bool value) async {
    final messenger = ScaffoldMessenger.of(context);
    if (value && !await NotificationService.instance.requestPermission()) {
      messenger.showSnackBar(const SnackBar(
          content: Text('Notification permission was not granted.')));
      return;
    }
    await StorageService.instance.setNotificationsEnabled(value);
    if (mounted) setState(() => _enabled = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Enable notifications'),
            subtitle: const Text('Allow SmakBook to send alerts'),
            value: _enabled,
            onChanged: _toggle,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.notifications_active),
            label: const Text('Send test notification'),
            onPressed: _enabled
                ? NotificationService.instance.showTestNotification
                : null,
          ),
        ],
      ),
    );
  }
}
