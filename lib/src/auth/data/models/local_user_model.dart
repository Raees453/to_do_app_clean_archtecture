import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/src/auth/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({required super.id, required super.name, required super.email});

  factory LocalUserModel.fromJson(Json json) {
    return LocalUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  factory LocalUserModel.fromFirebaseUser(User user) {
    return LocalUserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email!,
    );
  }

  Json toJson() => {'id': id, 'email': email, 'name': name};
}
