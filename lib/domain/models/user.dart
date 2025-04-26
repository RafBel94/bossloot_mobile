class User {
  final int id;
  final String? email;
  final String name;
  final String? mobilePhone;
  final String? address_1;
  final String? address_2;
  final int level;
  final int? points;
  final String? role;
  final bool? activated;
  final bool? emailConfirmed;
  final String profilePicture;
  final String? token;

  User({
    required this.id,
    this.email,
    required this.name,
    this.mobilePhone,
    this.address_1,
    this.address_2,
    required this.level,
    this.points,
    this.role,
    this.activated,
    this.emailConfirmed,
    required this.profilePicture,
    this.token,
  });

  factory User.fromLoginJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      mobilePhone: json['mobile_phone'],
      address_1: json['address_1'],
      address_2: json['address_2'],
      level: json['level'],
      points: json['points'],
      role: json['role'],
      activated: json['activated'] == 1,
      emailConfirmed: json['emailConfirmed'] == 1,
      profilePicture: json['profile_picture'] ?? 'images/avatar-placeholder.png',
      token: json['token'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      mobilePhone: json['mobile_phone'],
      address_1: json['address_1'],
      address_2: json['address_2'],
      level: json['level'],
      points: json['points'],
      role: json['role'],
      activated: json['activated'] == 1,
      emailConfirmed: json['email_confirmed'] == 1,
      profilePicture: json['profile_picture'] ?? 'images/avatar-placeholder.png',
    );
  }

  factory User.fromValorationJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      profilePicture: json['profile_picture'] ?? 'images/avatar-placeholder.png',
    );
  }
}