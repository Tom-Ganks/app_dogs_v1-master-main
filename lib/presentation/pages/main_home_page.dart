import 'package:app_dogs/presentation/pages/Dogs/dog_page.dart';
import 'package:app_dogs/presentation/pages/pessoas/pessoa_page.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Bem vindo ao App de Gestão!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Gerencie seus pets e clientes de forma facil e rapida',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.pets),
          label: const Text('Acessar Dogs'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DogPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.pets),
          label: const Text('Acessar Clientes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PessoaPage()),
            );
          },
        ),
      ]),
    );
  }
}
