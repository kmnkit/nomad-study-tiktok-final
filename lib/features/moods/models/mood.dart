import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood.freezed.dart';
part 'mood.g.dart';

@unfreezed
class MoodModel with _$MoodModel {
  factory MoodModel({
    required String id,
    required String text,
    required int likes,
    required int replies,
    required int emojiIndex,
    required final String creatorUid,
    required final int created,
  }) = _MoodModel;
  factory MoodModel.fromJson(Map<String, Object?> json) => _$MoodModelFromJson(json);
}
