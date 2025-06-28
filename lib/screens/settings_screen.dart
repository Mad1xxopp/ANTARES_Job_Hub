import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/notifications_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notificationsProvider = Provider.of<NotificationsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader(context, 'Внешний вид'),
            SwitchListTile(
              title: const Text('Темная тема'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),

            _buildSectionHeader(context, 'Уведомления'),
            SwitchListTile(
              title: const Text('Получать уведомления'),
              value: notificationsProvider.notificationsEnabled,
              onChanged: (value) {
                notificationsProvider.toggleNotifications(value);
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),

            _buildSectionHeader(context, 'О приложении'),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Версия'),
              subtitle: const Text('1.0.0'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}