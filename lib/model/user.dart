import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  @JsonKey(includeIfNull: false)
  int           id;
  String        firstName;
  String        lastName;
  final String  email;
  final String  password;
  bool          enabled;
  int           age;

  User (this.firstName, this.lastName, this.email, this.password, this.enabled, this.age);
  User.withId (this.id, this.firstName, this.lastName, this.email, this.password, this.enabled, this.age);
  User.withEmailPassword (this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

/*  int get id => _id; // fat operator '=>' means return
  String get email => _email;
  String get password => _password;

  set email (String email) {
    _email = email;
  }

  set password (String password) {
    _password = password;
  }*/

/*  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);*/
  /*Map <String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["email"] = _email;
    map["password"] = _password;
    if(_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  User.fromObject(dynamic o){
    this._id = o["id"];
    this._email = o["email"];
    this._password = o["password"];
  }*/

}