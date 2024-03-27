import 'package:flutter/material.dart';
import 'package:opt120/Components/menu.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _isobscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("Criar usuário"),
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
                    "Cadastrar novo usuário",
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
                      label: Text("Usuário"
                      ),
                    ),

                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      label: Text("E-mail"
                      ),
                    ),

                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscureText: _isobscure,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _isobscure =! _isobscure;
                          });
                      }, icon: Icon(_isobscure ? Icons.visibility : Icons.visibility_off)),
                      label: const Text("Senha"
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
