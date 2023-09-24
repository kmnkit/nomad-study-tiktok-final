import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signIn(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signInForm);

    state = await AsyncValue.guard(
      () async => await _repository.signIn(
        form["email"],
        form["password"],
      ),
    );
    if (!state.hasError) {
      context.go(RoutePath.profile);
    }
  }
}

final signInForm = StateProvider((ref) => {});

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
