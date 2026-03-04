import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/core/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return ListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text(
                        'Toggle between light and dark theme',
                      ),
                      trailing: Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('Whale Staff HRMS v1.0.0'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
