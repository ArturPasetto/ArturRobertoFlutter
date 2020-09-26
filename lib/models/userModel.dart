
class UserModel {

  final String uid;
  String _email;
  String _senha;

  UserModel({this.uid});

  String get getEmail => this._email;
  String get getSenha => this._senha;
  set setEmail(String value) => this._email = value;
  set setSenha(String value) => this._senha = value;

}