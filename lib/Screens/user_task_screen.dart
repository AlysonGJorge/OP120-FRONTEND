import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opt120/Components/menu.dart';
import 'package:http/http.dart' as api;

import '../Models/UserTask.dart';

class UserTaskScreen extends StatefulWidget {
  const UserTaskScreen({super.key});

  @override
  State<UserTaskScreen> createState() => _UserTaskScreenState();
}

class _UserTaskScreenState extends State<UserTaskScreen> {
  Future<void> deletarUserTask(int idUser) async {
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

  Future<void> atualizarUserTask(int idUser, String nmUser, String nmEmail, String cdSenha) async {
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

  final TextEditingController _id_user = TextEditingController();
  final TextEditingController _id_task = TextEditingController();
  final TextEditingController _dt_entrega = TextEditingController();
  final TextEditingController _nr_nota = TextEditingController();
  final TextEditingController _Changeduser = TextEditingController();
  final TextEditingController _Changedtask = TextEditingController();
  final TextEditingController _Changedentrega = TextEditingController();
  final TextEditingController _Changednota = TextEditingController();


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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    padding: const EdgeInsets.all(50),
                    width: 850,
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
                          controller: _id_user,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            label: Text("Id do aluno"
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _id_task,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.title,
                              color: Colors.black,
                            ),
                            label: Text("id da Atividade"
                            ),
                          ),

                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _nr_nota,
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
                          controller: _dt_entrega,
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
                          onPressed: () async {
                            final uri = Uri.parse('http://localhost:3000/UsuarioFezAtividade');
                            var response = await api.post(
                              uri,
                              headers: {'Content-Type': 'application/json'},
                              body: jsonEncode({
                                'id_user': _id_user.text,
                                'id_atividade': _id_task.text,
                                'dt_entrega': _dt_entrega.text,
                                'nr_nota': _nr_nota.text,
                              }),
                            );
                            if (response.statusCode == 201) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Usuário fez atividade!',
                                    style: TextStyle(color: Colors.white)),
                              ));
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Erro ao vincular usuário a uma atividade',
                                    style: TextStyle(color: Colors.white)),
                              ));
                            }
                          },
                          child: const Text("Criar usuário"),
                        ),
                        FutureBuilder<List<UserTask>>(
                          future: pegaUser(),
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
                                                          controller: _Changeduser,
                                                          decoration: const InputDecoration(
                                                            label: Text("Usuário"),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller: _Changedtask,
                                                          decoration: const InputDecoration(
                                                            label: Text("E-mail"),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                            controller: _nr_nota,
                                                            decoration: InputDecoration(
                                                                label: Text("Data Entrega"))
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
            )),
      ),
    );
  }
}
