import 'dart:convert';

import 'package:app_dogs/data/models/pessoa_model.dart';
import 'package:app_dogs/data/repositories/pessoa_repository.dart';
import 'package:app_dogs/presentation/viewmodels/pessoa_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PessoaPageForm extends StatefulWidget {
  const PessoaPageForm({super.key});

  @override
  State<PessoaPageForm> createState() => _PessoaPageFormState();
}

class _PessoaPageFormState extends State<PessoaPageForm> {
  _buscarEndereco(String cep) async {
    if (cep.length != 8) return;

    try {
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

      if (!mounted) return; // verifica se o widget ainda está montado

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.contaisKey('erro')) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cep não Encontrado')),
            );
          }
          return;
        }

        setState(() {
          _enderecoAvRuaController.text = data['logradouro'] ?? '';
          _enderecoCidadeController.text = data['localidade'] ?? '';
          _enderecoEstadoController.text = data['uf'] ?? '';
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar endereço')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar o endereço')),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoAvRuaController = TextEditingController();
  final _enderecoCepController = TextEditingController();
  final _enderecoCidadeController = TextEditingController();
  final _enderecoNumeroController = TextEditingController();
  final _enderecoEstadoController = TextEditingController();
  final PessoaViwemodel _viewModel = PessoaViwemodel(PessoaRepository());

  Future<void> savePessoa() async {
    if (_formKey.currentState!.validate()) {
      final pessoa = Pessoa(
        name: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
        enderecoAvRua: _enderecoAvRuaController.text,
        enderecoCep: _enderecoCepController.text,
        enderecoCidade: _enderecoCidadeController.text,
        enderecoNumero: _enderecoNumeroController.text,
        enderecoEstado: _enderecoEstadoController.text,
      );
      // print(pessoa.toMap());
      await _viewModel.addPessoa(pessoa);

      // Verifica se o widget ainda está montado antes de exibir o Snackbar ou navegar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pessoa adicionada com sucesso!')),
        );
        Navigator.pop(context); // Fecha a página após salvar
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Pessoas'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'Cadastrar uma nova Pessoa',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _nomeController,
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor entre com um nome';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _telefoneController,
                            decoration: InputDecoration(
                              labelText: 'telefone',
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor entre com o número de contato';
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
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                            onChanged: (value) {
                              if (value.length == 8) _buscarEndereco(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Cep',
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700),
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
                            onPressed: savePessoa,
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
                              'Salvar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
