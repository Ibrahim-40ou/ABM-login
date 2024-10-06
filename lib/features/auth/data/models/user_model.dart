import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.phoneNumber,
    required super.governorate,
    required super.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phoneNumber: json['phone'],
      profilePicture: json['avatar'] ?? '',
      governorate:
          json['governorate'] != null ? json['governorate']['name'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'governorate': governorate,
      'profilePicture': profilePicture,
    };
  }
}
