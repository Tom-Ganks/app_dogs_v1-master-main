import 'package:app_dogs/data/models/pessoa_model.dart';

import '../../data/repositories/pessoa_repository.dart';

class PessoaViwemodel {
  final PessoaRepository repository;

  PessoaViwemodel(this.repository);

  Future<void> addPessoa(Pessoa pessoa) async {
    await repository.insertPessoa(pessoa);
  }

  Future<List<Pessoa>> getPessoas() async {
    return await repository.getPessoas();
  }

  Future<void> updatePessoa(Pessoa pessoa) async {
    await repository.updatePessoa(pessoa);
  }

  Future<void> deletePessoa(int? id) async {
    await repository.deletePessoa(id!);
  }
}
