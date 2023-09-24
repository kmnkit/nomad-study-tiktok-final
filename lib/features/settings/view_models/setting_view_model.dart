import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:study_final/features/settings/models/setting_model.dart';
import 'package:study_final/features/settings/repositories/setting_repository.dart';

class SettingsViewModel extends Notifier<SettingModel> {
  late final SettingsRepository _repository;

  @override
  SettingModel build() {
    _repository = ref.read(settingRepo);
    return _repository.getSetting();
  }

  Future<void> _updateSetting(
      SettingModel Function(SettingModel current) updateFn) async {
    final currentSetting = _repository.getSetting();
    final updatedSetting = updateFn(currentSetting);
    await AsyncValue.guard(
      () async => await _repository.setSetting(updatedSetting),
    );

    state = updatedSetting;
  }

  void setPrivacy(bool value) async =>
      await _updateSetting((current) => current.copyWith(isPrivate: value));

  void setDarkMode(bool value) async =>
      await _updateSetting((current) => current.copyWith(isDarkMode: value));

  bool isDarkMode() => _repository.getSetting().isDarkMode;

  bool isPrivate() => _repository.getSetting().isPrivate;
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingModel>(
  () => SettingsViewModel(),
);
