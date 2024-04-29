import 'package:flutter/material.dart';
import '../Components/menu.dart';
import '../Services/token.dart';

class HomeScreen extends StatefulWidget {
  final String token; // Adicione um campo para armazenar o token

  HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _token; // Adicione um campo para armazenar o token no estado

  @override
  void initState() {
    super.initState();
    _token = widget.token; // Inicialize o campo de token no initState()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("Tela Inicial"),
      ),
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
                      'Bem-vindo!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Token: $_token', // Use o campo de token definido no estado
                      style: const TextStyle(fontSize: 20),
                    ),
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

