import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';
import 'package:study_final/features/moods/repositories/mood_repository.dart';

class LoveMoodViewModel extends FamilyAsyncNotifier<bool, String> {
  late final MoodRepository _repository;
  late final String _moodId;
  bool _isLoved = false;

  @override
  FutureOr<bool> build(String arg) async {
    _moodId = arg;
    _repository = ref.read(moodRepo);
    final user = ref.read(authRepo).user;
    _isLoved = await _repository.isLoved(_moodId, user!.uid);
    return _isLoved;
  }

  Future<void> loveMood() async {
    final user = ref.read(authRepo).user;
    await _repository.loveMood(_moodId, user!.uid);
    _isLoved = !_isLoved;
    state = AsyncValue.data(_isLoved);
  }
}

final loveMoodProvider = AsyncNotifierProvider.family<LoveMoodViewModel, bool, String>(
  () => LoveMoodViewModel(),
);
