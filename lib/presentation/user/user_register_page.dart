import 'package:flutter/material.dart';

import '../../core/database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo de E-mail
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10), // Espaço entre os campos

              // Campo de Username
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10), // Espaço entre os campos

              // Campo de Senha
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Espaço antes do botão

              // Botão de Cadastro
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crie um objeto usuário
                    User user = User(
                      email: _emailController.text,
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );

                    // Salve o usuário no banco de dados
                    DatabaseHelper().createUser(user);

                    // Navegue para a página de login
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Cadastrar'),
                ),
              ),
              const SizedBox(height: 10), // Espaço antes do texto

              // Texto para login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Já tem conta? '),
                  GestureDetector(
                    onTap: () {
                      // Navegar para a página de login
                    },
                    child: const Text(
                      'Clique aqui para entrar',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
