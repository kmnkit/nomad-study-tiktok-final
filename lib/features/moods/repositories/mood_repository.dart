import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uuid/uuid.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var uuid = const Uuid();
  static String moodCollectionKey = 'moods';

  Future<void> postNewMood(Map<String, dynamic> moodJson) async =>
      await _db.collection(moodCollectionKey).add(moodJson);

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoods({
    int? lastItemCreated,
    String? userUid,
  }) async {
    final ref = _db.collection(moodCollectionKey);
    final query = ref.orderBy("created", descending: true).limit(10);

    if (lastItemCreated == null) {
      return await query.get();
    } else {
      return await query.startAfter([lastItemCreated]).get();
    }
  }

  Future<void> deleteMood(String id, String userUid) async {
    await _db.collection(moodCollectionKey).doc(id).delete();
    await _db
        .collection("loves")
        .doc(userUid)
        .collection(moodCollectionKey)
        .doc(id)
        .delete();
  }

  Future<void> loveMood(String moodId, String userUid) async {
    final ref =
        _db.collection("loves").doc(userUid).collection(moodCollectionKey).doc(moodId);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({});
    }
  }

  Future<bool> isLoved(String moodId, String userUid) async {
    final ref =
        _db.collection("loves").doc(userUid).collection(moodCollectionKey).doc(moodId);
    final doc = await ref.get();
    return doc.exists;
  }
}

final moodRepo = Provider(
  (ref) => MoodRepository(),
);
