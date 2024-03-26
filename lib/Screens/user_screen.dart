import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _emailUsuarioController = TextEditingController();
  final TextEditingController _senhaUsuarioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(450),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Column(children: [
                const Text("Cadastro de usuário",
                  style: TextStyle(color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                  const SizedBox(width: 100, height: 100,),
                  TextField(decoration:  InputDecoration(
                    hintText: "Insira seu nome de usuário",
                  ),
                  controller: _nomeUsuarioController,
                  ),
                  SizedBox(width: 100),
                TextField(decoration: const InputDecoration(
                  hintText: "Insira seu nome de usuário",
                ),
                  controller: _nomeUsuarioController,
                ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

