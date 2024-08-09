import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  final String id;
  final String name;
  final String email;

  const LocalUser({required this.id, required this.name, required this.email});

  LocalUser copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      LocalUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  @override
  String toString() => 'LocalUser{id: $id, name: $name, email: $email}';

  // email here is just a fallback since it's going to be unique always
  @override
  List<Object?> get props => [id, email];
}
