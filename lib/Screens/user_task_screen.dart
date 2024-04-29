import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opt120/Components/menu.dart';
import 'package:http/http.dart' as api;
import '../Models/UserTask.dart'; // Importe o modelo UserTask

class UserTaskScreen extends StatefulWidget {
  const UserTaskScreen({Key? key});

  @override
  State<UserTaskScreen> createState() => _UserTaskScreenState();
}

class _UserTaskScreenState extends State<UserTaskScreen> {
  final TextEditingController _idUser = TextEditingController();
  final TextEditingController _idAtividade = TextEditingController();
  final TextEditingController _dtEntrega = TextEditingController();
  final TextEditingController _nrNota = TextEditingController();

  List<UserTask> userTasks = []; // Definindo a lista de UserTask

  Future<void> deletarUserTask(int idUser, String idAtividade) async {
    final uri = Uri.parse('http://localhost:3000/deletar/user/$idUser/task/$idAtividade');
    var response = await api.delete(uri);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Usuário-Tarefa deletado com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
      // Atualize o estado após a exclusão
      setState(() {
        userTasks.removeWhere((task) => task.id_user == idUser && task.id_atividade == idAtividade);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Erro ao deletar Usuário-Tarefa',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<void> criarUserTask(int idUser, String idAtividade, String dtEntrega, String nrNota) async {
    final uri = Uri.parse('http://localhost:3000/user/$idUser/task/$idAtividade');
    var response = await api.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'dt_entrega': dtEntrega,
        'nr_nota': nrNota,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Usuário-Tarefa criado com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Erro ao criar Usuário-Tarefa',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<List<UserTask>> pegaUserTasks() async {
    final uri = Uri.parse('http://localhost:3000/all');
    var response = await api.get(uri);

    if (response.statusCode == 200) {
      var users = jsonDecode(response.body) as List;
      print(users);  // Mova esta linha para aqui
      return users.map((item) => UserTask.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("Gerenciar Usuários-Tarefas"),
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
                    width: 870,
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Gerenciar Usuários-Tarefas",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        // Aqui você pode adicionar campos para manipular dados de UserTask
                        TextFormField(
                          controller: _idUser,
                          decoration: const InputDecoration(
                            labelText: 'ID Usuário',
                          ),
                        ),
                        TextFormField(
                          controller: _idAtividade,
                          decoration: const InputDecoration(
                            labelText: 'ID Atividade',
                          ),
                        ),
                        TextFormField(
                          controller: _dtEntrega,
                          decoration: const InputDecoration(
                            labelText: 'Data de Entrega',
                          ),
                        ),
                        TextFormField(
                          controller: _nrNota,
                          decoration: const InputDecoration(
                            labelText: 'Nota',
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () async {
                            criarUserTask(int.parse(_idUser.text), _idAtividade.text, _dtEntrega.text, _nrNota.text);
                          },
                          child: const Text("Criar Usuário-Tarefa"),
                        ),
                        FutureBuilder<List<UserTask>>(
                          future: pegaUserTasks(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return DataTable(
                                columnSpacing: 10, // Espaçamento entre as colunas
                                columns: [
                                  DataColumn(label: Text('ID Usuário')),
                                  DataColumn(label: Text('ID Atividade')),
                                  DataColumn(label: Text('Data de Entrega')),
                                  DataColumn(label: Text('Nota')),
                                  DataColumn(label: Text('Atualizar')),
                                  DataColumn(label: Text('Deletar')),
                                ],
                                rows: snapshot.data?.map<DataRow>((userTask) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(userTask.id_user.toString(), overflow: TextOverflow.ellipsis)), // Truncar texto se necessário
                                      DataCell(Text(userTask.id_atividade.toString(), overflow: TextOverflow.ellipsis)), // Truncar texto se necessário
                                      DataCell(Text(userTask.dt_entrega)),
                                      DataCell(Text(userTask.nr_nota)),
                                      DataCell(IconButton(
                                        icon: Icon(Icons.update),
                                        onPressed: () {
                                          // Implemente a lógica para atualizar aqui
                                          // Deve abrir um modal para editar os dados
                                        },
                                      )),
                                      DataCell(IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          deletarUserTask(userTask.id_user, userTask.id_atividade); // Passando os parâmetros corretamente
                                          setState(() {});
                                        },
                                      )),
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
          ),
        ),
      ),
    );
  }
}
