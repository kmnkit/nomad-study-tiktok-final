import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String userUid, String token) async =>
      await _db.collection("users").doc(userUid).update({"token": token});

  Future<void> updateUserToken(String userUid) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    updateToken(userUid, token);
    _messaging.onTokenRefresh.listen(
      (newToken) => updateToken(userUid, newToken),
    );
  }
}

final notificationRepo = Provider(
  (ref) => NotificationRepository(),
);
