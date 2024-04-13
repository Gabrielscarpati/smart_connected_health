class UserEntity extends Entity {
  final String email;
  final String firstName;
  final String lastName;

  UserEntity({
    required super.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}

abstract class Entity {
  final String id;

  Entity({required this.id});

  Map<String, dynamic> toJson();
}
