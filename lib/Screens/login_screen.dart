import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opt120/Screens/register_screen.dart';
import '../Components/menu.dart';
import '../Services/token.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  Future<void> _realizarLogin(BuildContext context, String email, String senha) async {
    final uri = Uri.parse('http://localhost:3000/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nm_email': email,
        'cd_senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(token: token
      )),
      );
    } else {
      print('Erro ao realizar login. Código de status: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciais inválidas. Por favor, tente novamente.'),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      drawer: Menu(),
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Faça Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      controller: _email,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      controller: _senha,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _realizarLogin(context, _email.text, _senha.text);
                      },
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()));

                    }, child: Text('Registrar'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
