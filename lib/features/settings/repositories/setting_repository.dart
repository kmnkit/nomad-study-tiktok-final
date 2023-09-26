import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_final/features/settings/models/setting_model.dart';

class SettingsRepository {
  static const String _settingKey = "settings";

  final Box<SettingModel> _settingsBox = Hive.box<SettingModel>(_settingKey);

  Future<void> setSetting(SettingModel setting) async =>
      await _settingsBox.put(_settingKey, setting);

  SettingModel getSetting() {
    final setting = _settingsBox.get(
      _settingKey,
      defaultValue: SettingModel(
        isDarkMode: false,
        isPrivate: false,
      ),
    )!;

    return setting;
  }
}

final settingRepo = Provider((ref) => SettingsRepository());
