class UserApp {
  final String username;
  final String email;
  final String password;
  final String? image;

  UserApp({
    required this.username,
    required this.email,
    required this.password,
    this.image,
  });

  factory UserApp.fromFirestore(Map<String, dynamic> json) => UserApp(
        username: json["name"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );

  static Map<String, dynamic> toMap(UserApp userApp) => {
        "username": userApp.username,
        "email": userApp.email,
        "password": userApp.password,
        "image": userApp.image,
      };
}
