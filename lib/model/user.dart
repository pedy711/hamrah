class User{
  int _id;
  String _email;
  String _password;

  User (this._email, this._password);
  User.withId (this._id, this._email, this._password);

  int get id => _id; // fat operator '=>' means return
  String get email => _email;
  String get password => _password;

  set email (String email) {
    _email = email;
  }

  set password (String password) {
    _password = password;
  }

  Map <String, dynamic> toMap() {
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
  }

}