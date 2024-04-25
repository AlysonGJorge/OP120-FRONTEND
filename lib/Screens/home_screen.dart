import 'package:flutter/material.dart';

import '../Components/menu.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      //bottomNavigationBar: ,
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
                  height: 700,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Seja muito Bem-Vindo, Não tem nada aqui",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
