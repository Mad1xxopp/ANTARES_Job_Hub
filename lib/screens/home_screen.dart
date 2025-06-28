import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'specializations_screen.dart';
import 'settings_screen.dart';
import '../provider/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANTARES Job Hub'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Логотип и приветствие
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Добро пожаловать!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // О приложении
            Text(
              'О платформе',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Мы объединяем профессионалов в строительной и инженерной отраслях. '
                  'Выбирайте специализации, оставляйте отклики и находите лучшие проекты!',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),

            // Мини-превью возможностей
            Text(
              'Возможности',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              icon: Icons.search,
              title: '10+ специализаций',
              description: 'Все ключевые направления строительства и инженерии',
            ),
            _buildFeatureCard(
              context,
              icon: Icons.send,
              title: 'Быстрый отклик',
              description: 'Отправляйте заявки в 2 клика',
            ),
            _buildFeatureCard(
              context,
              icon: Icons.verified_user,
              title: 'Проверенные проекты',
              description: 'Только надежные компании и заказчики',
            ),
            const SizedBox(height: 40),

            // Кнопка перехода
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Перейти к специализациям'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SpecializationsScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}