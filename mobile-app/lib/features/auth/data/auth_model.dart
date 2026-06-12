class UserModel {
  final String username;
  final String token;
  final bool isAuthenticated;
  final String ?email;
  final String ? refreshToken;
  final String? fullname;

  UserModel( {
    required this.username,
    required this.token,
    required this.isAuthenticated,
    this.email,
    this.refreshToken,
    this.fullname
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"]??"",
      username: json["userName"] ?? "",
      token: json["token"] ?? "",
      isAuthenticated: json["isAuthenticated"] ?? false,
      refreshToken:  json["refreshToken"] ?? "",
      fullname: json["fullName"] ?? "",
    );
  }
}