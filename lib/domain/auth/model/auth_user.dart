import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? email;
  final bool isEmailVerified;

  const AuthUser({
    required this.uid,
    required this.isEmailVerified,
    this.email,
  });

  @override
  List<Object?> get props => <Object?>[
    uid,
    isEmailVerified,
    email,
  ];
}
