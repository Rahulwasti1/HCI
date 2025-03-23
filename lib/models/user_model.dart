class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? gender;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender,
      'profile_image': profileImage,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
