class UserModel{
  final String email;
  final String? imageURL;
  final String name;

  UserModel({
    required this.email,
    this.imageURL,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> userData) {
    return UserModel(
      email: userData['email'],
      imageURL: userData['imageURL'],
      name: userData['name'],
    );

  }

}