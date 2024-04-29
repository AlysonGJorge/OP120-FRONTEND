import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _registrar() async {
    final String nome = _nomeController.text.trim();
    final String email = _emailController.text.trim();
    final String senha = _senhaController.text.trim();

    final uri = Uri.parse('http://localhost:3000/user');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nm_user': nome,
        'nm_email': email,
        'cd_senha': senha,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário registrado com sucesso!'),
        ),
      );
      // Após o registro bem-sucedido, navegue para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(), // Substitua LoginScreen pela sua tela de login
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao registrar usuário. Por favor, tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome de Usuário',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _registrar,
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
