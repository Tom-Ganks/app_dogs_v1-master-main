import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );

        await db.execute('CREATE TABLE pessoa('
            'id INTEGER PRIMARY KEY, '
            'name TEXT NOT NULL, '
            'email TEXT, '
            'telefone TEXT, '
            'enderecoAvRua TEXT, '
            'enderecoNumero TEXT, '
            'enderecoCep TEXT, '
            'enderecoCidade TEXT, '
            'enderecoEstado TEXT)');

        await db.execute('CREATE TABLE login('
            'id INTEGER PRIMARY KEY, '
            'usuario TEXT NOT NULL UNIQUE, '
            'senha TEXT NOT NULL, '
            'id_pessoa INTEGER NOT NULL UNIQUE, '
            'FOREIGN KEY (id_pessoa) REFERENCES pessoa(id))');
      },
      version: 2,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('CREATE TABLE login('
              'id INTEGER PRIMARY KEY, '
              'usuario TEXT NOT NULL UNIQUE, '
              'senha TEXT NOT NULL, '
              'id_pessoa INTEGER NOT NULL UNIQUE, '
              'FOREIGN KEY (id_pessoa) REFERENCES pessoa(id))');
        }
      },
    );
  }
}
