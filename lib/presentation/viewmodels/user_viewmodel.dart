import 'package:app_dogs/data/models/user_model.dart';
import 'package:app_dogs/data/repositories/user_repository.dart';

class UserViewmodel {
  final UserRepository repository;

  UserViewmodel(this.repository);

  // Metodo para cadastrar um novo usuario, verificando se o e-mail existe na tabela pessoas.
  Future<String> registerUser(
      String email, String username, String password) async {
    final emailExists =
        await repository.emailExists(email); // Deve retornar um bool

    if (emailExists) {
      // Certifique-se de que EmailExists é bool
      final db = await repository.initDb();
      final result =
          await db.query('pessoas', where: 'email = ?', whereArgs: [email]);
      final idPessoa = result[0]['id'] as int;

      // Verifica se ja existe um usuario com idPessoa
      final userAlreadyExists = await repository.userExistsByIdPessoa(idPessoa);
      if (userAlreadyExists) {
        return 'Usuário já está cadastrado';
      }
      final user =
          UserModel(username: username, password: password, idpessoa: idPessoa);
      await repository.insertUser(user);

      return 'Usuario cadastrado com sucesso';
    } else {
      return 'Email não encontrado, Procure o administrador.';
    }
  }

  // Metodo para verificar as credenciais de login
  Future<bool> loginUser(String username, String password) async {
    return await repository.verifyLogin(username, password);
  }
}
