import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> signUp(String email, String password) async =>
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signIn(String email, String password) async =>
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signOut() async => await _firebaseAuth.signOut();
}

final authRepo = Provider((ref) => AuthRepository());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
