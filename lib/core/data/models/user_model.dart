import '../../domain/entities/user.dart';

class UserModel extends Usuario {
  const UserModel({
    required super.id,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as Map<String, dynamic>,
    );
  }
}
