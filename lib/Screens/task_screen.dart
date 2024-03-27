import 'package:flutter/material.dart';

import '../Components/menu.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("Criar Atividade"),
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
                        "Cadastro de Atividade",
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
                            Icons.title,
                            color: Colors.black,
                          ),
                          label: Text("Título"
                          ),
                        ),

                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.black,
                          ),
                          label: Text("Descrição"
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
                          label: Text("Data Limite"
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
