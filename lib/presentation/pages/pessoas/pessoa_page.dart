import 'package:app_dogs/presentation/pages/pessoas/pessoa_details_page.dart';
import 'package:app_dogs/presentation/pages/pessoas/pessoa_edit_page.dart';
import 'package:app_dogs/presentation/pages/pessoas/pessoa_page_form.dart';
import 'package:app_dogs/presentation/viewmodels/pessoa_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../data/models/pessoa_model.dart';
import '../../../data/repositories/pessoa_repository.dart';

class PessoaPage extends StatefulWidget {
  const PessoaPage({super.key});

  @override
  PessoaPageState createState() => PessoaPageState();
}

class PessoaPageState extends State<PessoaPage> {
  List<Pessoa> _pessoas = [];
  final PessoaViwemodel _viewModel = PessoaViwemodel(PessoaRepository());
  Pessoa? _lastDeletedPessoa;

  @override
  void initState() {
    super.initState();
    _loadPessoas();
  }

  Future<void> _loadPessoas() async {
    _pessoas = await _viewModel.getPessoas();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deletePessoa(Pessoa pessoa) async {
    await _viewModel.deletePessoa(pessoa.id!);
    _lastDeletedPessoa = pessoa;

    final snackBar = SnackBar(
      content: Text('${pessoa.name} deletado'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          if (_lastDeletedPessoa != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Desfeita a exclusão de ${_lastDeletedPessoa!.name}'),
            ));
            _viewModel.addPessoa(_lastDeletedPessoa!);
            setState(() {
              _pessoas.add(_lastDeletedPessoa!);
              _lastDeletedPessoa = null;
            });
          }
        },
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    await _loadPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        backgroundColor: Colors.teal, // Alterando a cor da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _pessoas.isEmpty
            ? const Center(child: Text('Nenhum Cliente encontrado.'))
            : ListView.builder(
                itemCount: _pessoas.length,
                itemBuilder: (context, index) {
                  final pessoa = _pessoas[index];
                  return Card(
                    elevation: 5, // Sombra para o card
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Bordas arredondadas
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade300,
                        child: Text(
                          pessoa.name[0], // Primeira letra do nome
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        pessoa.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Telefone: ${pessoa.telefone}'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PessoaDetailsPage(pessoa: pessoa),
                                ),
                              );
                            },
                            child: const Text(
                              'Mais Detalhes',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PessoaEditPage(pessoa: pessoa)),
                              ).then((_) => _loadPessoas());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deletePessoa(pessoa);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PessoaPageForm()),
          ).then((_) => _loadPessoas());
        },
        backgroundColor: Colors.teal,
        tooltip: 'Adicionar Clientes', // Cor do botão
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
