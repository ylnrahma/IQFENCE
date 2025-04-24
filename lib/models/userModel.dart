class UserModel {
  final String uid;
  final String email;

  UserModel({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
