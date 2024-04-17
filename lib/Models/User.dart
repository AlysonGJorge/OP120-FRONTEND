class User {
  late int id_user;
  late String nm_user;
  late String nm_email;
  late String cd_senha;


  User(this.id_user, this.nm_user, this.nm_email, this.cd_senha);
  User.fromJson(Map<String, dynamic> json) {
    id_user = json['id_user'];
    nm_user = json['nm_user'];
    nm_email = json['nm_email'];
    cd_senha = json['cd_senha'];
  }
}