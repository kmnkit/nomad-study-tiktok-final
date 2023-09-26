// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) {
  return _MoodModel.fromJson(json);
}

/// @nodoc
mixin _$MoodModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  set likes(int value) => throw _privateConstructorUsedError;
  int get replies => throw _privateConstructorUsedError;
  set replies(int value) => throw _privateConstructorUsedError;
  int get emojiIndex => throw _privateConstructorUsedError;
  set emojiIndex(int value) => throw _privateConstructorUsedError;
  String get creatorUid => throw _privateConstructorUsedError;
  int get created => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoodModelCopyWith<MoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodModelCopyWith<$Res> {
  factory $MoodModelCopyWith(MoodModel value, $Res Function(MoodModel) then) =
      _$MoodModelCopyWithImpl<$Res, MoodModel>;
  @useResult
  $Res call(
      {String id,
      String text,
      int likes,
      int replies,
      int emojiIndex,
      String creatorUid,
      int created});
}

/// @nodoc
class _$MoodModelCopyWithImpl<$Res, $Val extends MoodModel>
    implements $MoodModelCopyWith<$Res> {
  _$MoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? likes = null,
    Object? replies = null,
    Object? emojiIndex = null,
    Object? creatorUid = null,
    Object? created = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      emojiIndex: null == emojiIndex
          ? _value.emojiIndex
          : emojiIndex // ignore: cast_nullable_to_non_nullable
              as int,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoodModelCopyWith<$Res> implements $MoodModelCopyWith<$Res> {
  factory _$$_MoodModelCopyWith(
          _$_MoodModel value, $Res Function(_$_MoodModel) then) =
      __$$_MoodModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      int likes,
      int replies,
      int emojiIndex,
      String creatorUid,
      int created});
}

/// @nodoc
class __$$_MoodModelCopyWithImpl<$Res>
    extends _$MoodModelCopyWithImpl<$Res, _$_MoodModel>
    implements _$$_MoodModelCopyWith<$Res> {
  __$$_MoodModelCopyWithImpl(
      _$_MoodModel _value, $Res Function(_$_MoodModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? likes = null,
    Object? replies = null,
    Object? emojiIndex = null,
    Object? creatorUid = null,
    Object? created = null,
  }) {
    return _then(_$_MoodModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      emojiIndex: null == emojiIndex
          ? _value.emojiIndex
          : emojiIndex // ignore: cast_nullable_to_non_nullable
              as int,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoodModel implements _MoodModel {
  _$_MoodModel(
      {required this.id,
      required this.text,
      required this.likes,
      required this.replies,
      required this.emojiIndex,
      required this.creatorUid,
      required this.created});

  factory _$_MoodModel.fromJson(Map<String, dynamic> json) =>
      _$$_MoodModelFromJson(json);

  @override
  String id;
  @override
  String text;
  @override
  int likes;
  @override
  int replies;
  @override
  int emojiIndex;
  @override
  final String creatorUid;
  @override
  final int created;

  @override
  String toString() {
    return 'MoodModel(id: $id, text: $text, likes: $likes, replies: $replies, emojiIndex: $emojiIndex, creatorUid: $creatorUid, created: $created)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoodModelCopyWith<_$_MoodModel> get copyWith =>
      __$$_MoodModelCopyWithImpl<_$_MoodModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoodModelToJson(
      this,
    );
  }
}

abstract class _MoodModel implements MoodModel {
  factory _MoodModel(
      {required String id,
      required String text,
      required int likes,
      required int replies,
      required int emojiIndex,
      required final String creatorUid,
      required final int created}) = _$_MoodModel;

  factory _MoodModel.fromJson(Map<String, dynamic> json) =
      _$_MoodModel.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get text;
  set text(String value);
  @override
  int get likes;
  set likes(int value);
  @override
  int get replies;
  set replies(int value);
  @override
  int get emojiIndex;
  set emojiIndex(int value);
  @override
  String get creatorUid;
  @override
  int get created;
  @override
  @JsonKey(ignore: true)
  _$$_MoodModelCopyWith<_$_MoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}
