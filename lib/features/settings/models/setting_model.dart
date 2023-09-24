import 'package:hive_flutter/hive_flutter.dart';

part 'setting_model.g.dart';

@HiveType(typeId: 0)
class SettingModel extends HiveObject {
  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  bool isPrivate;

  SettingModel({
    required this.isDarkMode,
    required this.isPrivate,
  });

  SettingModel copyWith({
    bool? isDarkMode,
    bool? isPrivate,
  }) {
    return SettingModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}
