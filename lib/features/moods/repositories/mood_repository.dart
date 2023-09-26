import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/moods/models/mood.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static String moodCollectionKey = 'moods';

  Future<void> postNewMood(MoodModel mood) async =>
      await _db.collection(moodCollectionKey).add(mood.toJson());

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoods({int? lastItemCreated}) async {
    final query = _db
        .collection(moodCollectionKey)
        .orderBy("created", descending: true)
        .limit(10);
    if (lastItemCreated == null) {
      return await query.get();
    } else {
      return await query.startAfter([lastItemCreated]).get();
    }
  }

  Future<void> deleteMood(String id) async =>
      await _db.collection(moodCollectionKey).doc(id).delete();

  Future<void> likeMood(String moodId, String userUid) async =>
      await _db.collection("likes").add({
        "moodId": moodId,
        "userId": userUid,
      });
}

final moodRepo = Provider(
  (ref) => MoodRepository(),
);
