import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opt120/Components/menu.dart';
import 'package:http/http.dart' as api;

import '../Models/User.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  Future<void> deletarUsuario(int idUser) async {
    final uri = Uri.parse('http://localhost:3000/deletar/user/$idUser');
    var response = await api.delete(uri);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Usuário deletado com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Erro ao deletar usuário',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<void> atualizarUsuario(int idUser, String nmUser, String nmEmail, String cdSenha) async {
    final uri = Uri.parse('http://localhost:3000/atualizar/user/$idUser');
    var response = await api.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nm_user': nmUser,
        'nm_email': nmEmail,
        'cd_senha': cdSenha,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Usuário atualizado com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Erro ao atualizar usuário',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<List<User>> pegaUsuarios() async {
    final uri = Uri.parse('http://localhost:3000/user');
    var response = await api.get(uri);

    if (response.statusCode == 200) {
      var users = jsonDecode(response.body) as List;
      print(users);  // Mova esta linha para aqui
      return users.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }

  bool _isobscure = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _Changeusername = TextEditingController();
  final TextEditingController _Changeemail = TextEditingController();
  final TextEditingController _Changepassword = TextEditingController();

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
            child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 850,
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Cadastrar um novo usuário",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: _username,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          label: Text("Usuário"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _email,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          label: Text("E-mail"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _password,
                        obscureText: _isobscure,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isobscure = !_isobscure;
                                });
                              },
                              icon: Icon(_isobscure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          label: const Text("Senha"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () async {
                          final uri = Uri.parse('http://localhost:3000/user');
                          var response = await api.post(
                            uri,
                            headers: {'Content-Type': 'application/json'},
                            body: jsonEncode({
                              'nm_user': _username.text,
                              'nm_email': _email.text,
                              'cd_senha': _password.text,
                            }),
                          );
                          if (response.statusCode == 201) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Usuário criado com sucesso!',
                                  style: TextStyle(color: Colors.white)),
                            ));
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Erro ao criar usuário',
                                  style: TextStyle(color: Colors.white)),
                            ));
                          }
                        },
                        child: const Text("Criar usuário"),
                      ),
                      FutureBuilder<List<User>>(
                        future: pegaUsuarios(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Usuário')),
                                DataColumn(label: Text('E-mail')),
                                DataColumn(label: Text('Senha')),
                                DataColumn(label: Text('Atualizar')),
                                DataColumn(label: Text('Deletar')),
                              ],
                              rows: snapshot.data?.map<DataRow>((user) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(user.id_user.toString())),
                                    DataCell(Text(user.nm_user)),
                                    DataCell(Text(user.nm_email)),
                                    DataCell(Text(user.cd_senha.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.update),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Atualizar usuário'),
                                                content: Form(
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        controller: _Changeusername,
                                                        decoration: const InputDecoration(
                                                          label: Text("Usuário"),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _Changeemail,
                                                        decoration: const InputDecoration(
                                                          label: Text("E-mail"),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _Changepassword,
                                                        obscureText: _isobscure,
                                                        decoration: InputDecoration(
                                                          suffixIcon: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  _isobscure = !_isobscure;
                                                                });
                                                              },
                                                              icon: Icon(_isobscure
                                                                  ? Icons.visibility
                                                                  : Icons.visibility_off)),
                                                          label: const Text("Senha"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Atualizar'),
                                                    onPressed: () {
                                                      atualizarUsuario(user.id_user, _Changeusername.text, _Changeemail.text, _Changepassword.text);
                                                      setState(() {});
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Cancelar'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          deletarUsuario(user.id_user);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList() ?? [],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
