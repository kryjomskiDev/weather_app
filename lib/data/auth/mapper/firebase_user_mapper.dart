import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';

extension FirebaseUserToAuthUser on User {
  AuthUser toAuthUser() => AuthUser(
    uid: uid,
    email: email,
    isEmailVerified: emailVerified,
  );
}
