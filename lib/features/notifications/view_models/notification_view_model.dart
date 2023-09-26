import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';
import 'package:study_final/features/notifications/repositories/notification_repository.dart';

class NotificationViewModel extends AsyncNotifier {
  late final NotificationRepository _repository;
  @override
  FutureOr build() async {
    _repository = NotificationRepository();
    final user = ref.read(authRepo).user;
    await _repository.updateUserToken(user!.uid);
  }
}

final notificationProvider = AsyncNotifierProvider<NotificationViewModel, void>(
  () => NotificationViewModel(),
);
