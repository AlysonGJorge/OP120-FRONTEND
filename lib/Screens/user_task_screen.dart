import 'package:flutter/material.dart';

import '../Components/menu.dart';

class UserTaskScreen extends StatelessWidget {
  const UserTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("Usuário fez atividade"),
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: const EdgeInsets.all(100),
                  height: 700,
                  width: 1000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Aluno fez a atividade",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          label: Text("Nome do Usuário"
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.title,
                            color: Colors.black,
                          ),
                          label: Text("Título da Atividade"
                          ),
                        ),

                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.text_increase,
                            color: Colors.black,
                          ),
                          label: Text("Nota do Aluno"
                          ),
                        ),

                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: Colors.black,
                          ),
                          label: Text("Data de Entrega"
                          ),
                        ),

                      ),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () {}, child: const Text("Criar usuário"))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
