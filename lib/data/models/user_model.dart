class UserModel {
  final int? id; // Permite ser null
  final String username;
  final String password;
  final int idpessoa;

  UserModel(
      {this.id,
      required this.username,
      required this.password,
      required this.idpessoa});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': username,
      'password': password,
      'idpessoa': idpessoa,
    };
  }
}
