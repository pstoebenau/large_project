class User {
  final String profileImage;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String about;

  User(this.profileImage, this.firstName, this.lastName, this.username, this.email, this.about);
  User.positional({ this.profileImage, this.firstName, this.lastName, this.username, this.email, this.about});

  factory User.empty() {
    return User('', '', '', '', '', '');
  }

  factory User.fromJson(Map json) {
    return User.positional(
      profileImage: json['profileImage'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      about: json['about'] ?? '',
    );
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'profileImage': user.profileImage,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'username': user.username,
      'email': user.email,
      'about': user.about,
    };
  }
}