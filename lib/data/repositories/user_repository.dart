import 'dart:convert';

import 'package:app_dogs/data/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'doogie_database.db'),
      version: 2,
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await initDb();
    final result =
        await db.query('pessoas', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty;
  }

  Future<bool> userExistsByIdPessoa(int idPessoa) async {
    final db = await initDb();
    final result =
        await db.query('login', where: 'id_pessoa = ?', whereArgs: [idPessoa]);
    return result.isNotEmpty;
  }

  insertUser(UserModel user) async {
    final db = await initDb();
    final encryptedPassword =
        sha256.convert(utf8.encode(user.password)).toString();
    await db.insert('login', user.toMap()..['password'] = encryptedPassword);
  }

  Future<bool> verifyLogin(String username, String password) async {
    final db = await initDb();
    final encryptedPassword = sha256.convert(utf8.encode(password)).toString();
    final result = await db.query('login',
        where: 'username = ? AND password = ?',
        whereArgs: [username, encryptedPassword]);
    return result.isNotEmpty;
  }

  getUsers() {}
}
