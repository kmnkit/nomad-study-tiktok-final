import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/settings/view_models/setting_view_model.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SwitchListTile.adaptive(
                  title: Text(isDarkMode ? "Dark Mode" : "Light Mode"),
                  value: ref.watch(settingsProvider).isDarkMode,
                  onChanged: (bool value) {
                    ref.read(settingsProvider.notifier).setDarkMode(value);
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
