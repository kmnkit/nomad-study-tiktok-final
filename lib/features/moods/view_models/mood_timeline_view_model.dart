import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/moods/models/mood.dart';
import 'package:study_final/features/moods/repositories/mood_repository.dart';
import 'package:study_final/utils.dart';

class MoodTimelineViewModel extends AsyncNotifier<List<MoodModel>> {
  late final MoodRepository _repository;
  List<MoodModel> _list = [];

  @override
  FutureOr<List<MoodModel>> build() async {
    _repository = ref.read(moodRepo);
    _list = await _fetchMoods(lastItemCreated: null);

    return _list;
  }

  Future<List<MoodModel>> _fetchMoods({int? lastItemCreated}) async {
    final result = await _repository.fetchMoods(lastItemCreated: lastItemCreated);

    final moods = result.docs.map((mood) => MoodModel.fromJson(mood.data()));

    return moods.toList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final moods = await _fetchMoods(lastItemCreated: null);
    _list = moods;
    state = AsyncValue.data(moods);
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchMoods(lastItemCreated: _list.last.created);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> deleteMood(BuildContext context, String id, String userUid) async {
    _repository.deleteMood(id, userUid);
    state = AsyncValue.data(_list);
    if (!context.mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text("Mood가 삭제되었습니다."),
        ),
      );
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

final timelineProvider = AsyncNotifierProvider<MoodTimelineViewModel, List<MoodModel>>(
    () => MoodTimelineViewModel());

final realtimeProvider = StreamProvider.autoDispose<List<MoodModel>>(
  (ref) {
    final db = FirebaseFirestore.instance;
    return db.collection("moods").orderBy("created", descending: true).snapshots().map(
          (event) => event.docs
              .map(
                (doc) => MoodModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  },
);
