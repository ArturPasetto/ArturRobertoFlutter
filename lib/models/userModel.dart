
class UserModel {

  final String uid;
  String email;
  String _senha;
  String nome;
  String telefone;
  DateTime aniversario;

  get getSenha => this._senha;
  set setSenha(value) => this._senha = value;

  UserModel({this.uid, this.nome, this.email, this.telefone, this.aniversario});

}