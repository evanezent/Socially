class UserModel {
  String userID, name, email;

  UserModel({this.userID, this.name, this.email});

  UserModel.toJson(Map<String, dynamic> map) {
    this.email = map["email"];
    this.name = map["name"];
    this.userID = map["id"];
  }
}
