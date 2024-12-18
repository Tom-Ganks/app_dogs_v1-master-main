import 'package:app_dogs/data/models/pessoa_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../core/database_helper.dart';

class PessoaRepository {
  Future<void> insertPessoa(Pessoa pessoa) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'pessoa',
      pessoa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pessoa>> getPessoa() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> pessoaMaps = await db.query('pessoa');
    return pessoaMaps.map((map) {
      return Pessoa(
          id: map['id'] as int,
          name: map['name'] as String,
          telefone: map['telefone'] as String,
          email: map['email'] as String,
          enderecoAvRua: map['enderecoAvRua'] as String,
          enderecoCep: map['enderecoCep'] as String,
          enderecoCidade: map['enderecoCidade'] as String,
          enderecoEstado: map['enderecoEstado'] as String,
          enderecoNumero: map['enderecoNumero'] as String);
    }).toList();
  }

  Future<void> updatePessoa(Pessoa pessoa) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'pessoa',
      pessoa.toMap(),
      where: 'id = ?',
      whereArgs: [pessoa.id],
    );
  }

  Future<void> deletePessoa(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'pessoa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
