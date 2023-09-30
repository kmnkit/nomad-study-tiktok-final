import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';
import 'package:study_final/features/moods/models/mood.dart';
import 'package:study_final/features/moods/repositories/mood_repository.dart';

import 'package:study_final/utils.dart';
import 'package:uuid/uuid.dart';

class NewMoodViewModel extends AsyncNotifier<void> {
  late final MoodRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(moodRepo);
  }

  Future<void> postNewMood(BuildContext context) async {
    final user = ref.read(authRepo).user;
    // final userProfile = ref.read(usersProvider).value;
    // if (userProfile == null) return;

    state = const AsyncValue.loading();
    final form = ref.read(postNewMoodForm);

    await AsyncValue.guard(() async {
      var uuid = const Uuid().v4();
      final mood = MoodModel(
        id: uuid,
        text: form['text'],
        likes: 0,
        replies: 0,
        creatorUid: user!.uid,
        emojiIndex: form['emojiIndex'],
        created: DateTime.now().millisecondsSinceEpoch,
      );
      await _repository.postNewMood(mood.toJson());
    });
    if (!context.mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text("새 Mood가 등록되었습니다."),
        ),
      );
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

final postNewMoodForm = StateProvider((ref) => {});

final newMoodProvider = AsyncNotifierProvider<NewMoodViewModel, void>(
  () => NewMoodViewModel(),
);
