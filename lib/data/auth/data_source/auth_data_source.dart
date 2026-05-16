import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  const AuthDataSource(this._firebaseAuth);

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = credential.user;

    if (user == null) {
      throw StateError('Sign-in succeeded but user is null');
    }

    return user;
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = credential.user;

    if (user == null) {
      throw StateError('Registration succeeded but user is null');
    }

    return user;
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<String?> getIdToken({bool forceRefresh = false}) {
    final User? user = _firebaseAuth.currentUser;

    if (user == null) {
      return Future<String?>.value();
    }

    return user.getIdToken(forceRefresh);
  }
}
