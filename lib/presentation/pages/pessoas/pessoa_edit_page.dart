import 'package:app_dogs/data/models/pessoa_model.dart';
import 'package:app_dogs/presentation/viewmodels/pessoa_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/pessoa_repository.dart';

class PessoaEditPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaEditPage({super.key, required this.pessoa});

  @override
  PessoaEditPageState createState() => PessoaEditPageState();
}

class PessoaEditPageState extends State<PessoaEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoAvRuaController = TextEditingController();
  final _enderecoCepController = TextEditingController();
  final _enderecoCidadeController = TextEditingController();
  final _enderecoNumeroController = TextEditingController();
  final _enderecoEstadoController = TextEditingController();
  final PessoaViwemodel _viewModel = PessoaViwemodel(PessoaRepository());

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.pessoa.name;
    _emailController.text = widget.pessoa.email.toString();
    _telefoneController.text = widget.pessoa.telefone.toString();
    _enderecoAvRuaController.text = widget.pessoa.enderecoAvRua.toString();
    _enderecoCepController.text = widget.pessoa.enderecoCep.toString();
    _enderecoCidadeController.text = widget.pessoa.enderecoCidade.toString();
    _enderecoNumeroController.text = widget.pessoa.enderecoNumero.toString();
    _enderecoEstadoController.text = widget.pessoa.enderecoEstado.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _enderecoAvRuaController.dispose();
    _enderecoCepController.dispose();
    _enderecoCidadeController.dispose();
    _enderecoNumeroController.dispose();
    _enderecoEstadoController.dispose();
    super.dispose();
  }

  _updatePessoa() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatePessoa = Pessoa(
        id: widget.pessoa.id, // mantem o id original
        name: _nameController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
        enderecoAvRua: _enderecoAvRuaController.text,
        enderecoCep: _enderecoCepController.text,
        enderecoCidade: _telefoneController.text,
        enderecoNumero: _enderecoNumeroController.text,
        enderecoEstado: _enderecoEstadoController.text,
      );

      await _viewModel.updatePessoa(updatePessoa);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dog atualizado com sucesso')),
        );
        Navigator.pop(context, updatePessoa);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição Pessoa'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Editar Pessoa',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com um nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com a Telefone';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor entre com um número válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com o Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _enderecoAvRuaController,
                        decoration: InputDecoration(
                          labelText: 'EnderecoAvRua',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor seu Endereço, Avenida ou Rua';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _enderecoCepController,
                        decoration: InputDecoration(
                          labelText: 'Cep',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor Insara seu Cep';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor entre com um Cep válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _enderecoCidadeController,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor Insira o nome de sua Cidade';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _enderecoNumeroController,
                        decoration: InputDecoration(
                          labelText: 'Numero',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com o número de sua casa';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor insira um número válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _enderecoEstadoController,
                        decoration: InputDecoration(
                          labelText: 'Estado',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor insira seu Estado';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _updatePessoa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        icon: const Icon(Icons.save, size: 24),
                        label: const Text(
                          'Salvar Alterações',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
