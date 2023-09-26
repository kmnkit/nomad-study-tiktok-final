import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/moods/models/mood.dart';
import 'package:study_final/features/moods/repositories/mood_repository.dart';

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

  Future<void> deleteMood(String id) async {
    _repository.deleteMood(id);
    _list.removeWhere((element) => element.id == id);
    state = AsyncValue.data(_list);
  }
}

final timelineProvider = AsyncNotifierProvider<MoodTimelineViewModel, List<MoodModel>>(
    () => MoodTimelineViewModel());
