import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOutViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final signOutProvider = AsyncNotifierProvider<SignOutViewModel, void>(
  () => SignOutViewModel(),
);
