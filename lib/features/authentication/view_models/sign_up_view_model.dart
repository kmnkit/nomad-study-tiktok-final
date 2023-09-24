import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(
      () async => await _repository.signUp(
        form["email"],
        form["password"],
      ),
    );
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
