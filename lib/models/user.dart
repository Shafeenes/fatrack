class User {
  String username;
  String name;
  String email;

  User({
    required this.username,
    required this.name,
    required this.email,
  });

  static User fromJson(dynamic json) {
    return User(
      username: json["username"],
      name: json["name"],
      email: json["email"],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    Map<String, dynamic> userJson = {};

    userJson["username"] = user.username;
    userJson["name"] = user.name;
    userJson["email"] = user.email;

    return userJson;
  }

  static List<User> toList(dynamic userJson) {
    List<User> users = [];
    userJson.forEach((element) {
      var userEle = fromJson(element);
      users.add(userEle);
    });
    return users;
  }
}
