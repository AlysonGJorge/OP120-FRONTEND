import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opt120/Components/menu.dart';
import 'package:http/http.dart' as api;
import '../Models/Task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _dstitle = TextEditingController();
  final TextEditingController _dstask = TextEditingController();
  final TextEditingController _dtlimite = TextEditingController();
  final TextEditingController _Changedstitle = TextEditingController();
  final TextEditingController _Changedstask = TextEditingController();
  final TextEditingController _Changedtlimite = TextEditingController();

  Future<void> deletarTask(int id_atividade) async {
    final uri = Uri.parse('http://localhost:3000/deletar/task/$id_atividade');
    var response = await api.delete(uri);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Atividade deletada com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Erro ao deletar atividade',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<void> atualizarTask(
      int idTask, String dstitulo, String dsatividade, String dtlimite) async {
    final uri = Uri.parse('http://localhost:3000/atualizar/Task/$idTask');
    var response = await api.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ds_titulo': dstitulo,
        'ds_Atividade': dsatividade,
        'dt_limite': dtlimite,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Atividade atualizada com sucesso!',
            style: TextStyle(color: Colors.white)),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Erro ao atualizar atividade',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  Future<List<Task>> pegaTasks() async {
    final uri = Uri.parse('http://localhost:3000/task');
    var response = await api.get(uri);

    if (response.statusCode == 200) {
      var Tasks = jsonDecode(response.body) as List;
      return Tasks.map((item) => Task.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar Atividades');
    }
  }

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
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                width: 870,
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
                      controller: _dstitle,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                          color: Colors.black,
                        ),
                        label: Text("Título"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _dstask,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        label: Text("Descrição"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _dtlimite,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.black,
                        ),
                        label: Text("Data Limite"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () async {
                        final uri = Uri.parse('http://localhost:3000/Task');
                        var response = await api.post(
                          uri,
                          headers: {'Content-Type': 'application/json'},
                          body: jsonEncode({
                            'ds_atividade': _dstitle.text,
                            'ds_titulo': _dstask.text,
                            'dt_limite': _dtlimite.text,
                          }),
                        );
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Atividade criada com sucesso!',
                                style: TextStyle(color: Colors.white)),
                          ));
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Erro ao criar atividade',
                                style: TextStyle(color: Colors.white)),
                          ));
                        }
                      },
                      child: const Text("Criar Atividade"),
                    ),
                    FutureBuilder<List<Task>>(
                      future: pegaTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return DataTable(
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('titulo')),
                              DataColumn(label: Text('descricao')),
                              DataColumn(label: Text('data')),
                              DataColumn(label: Text('Atualizar')), // Nova coluna
                              DataColumn(label: Text('Deletar')), // Nova coluna
                            ],
                            rows: snapshot.data?.map<DataRow>((Task) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(Task.id_atividade.toString())),
                                      DataCell(Text(Task.ds_titulo)),
                                      DataCell(Text(Task.ds_atividade)),
                                      DataCell(Text(Task.dt_limite.toString())),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.update),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Atualizar atividade'),
                                                  content: Form(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              _Changedstask,
                                                          decoration:
                                                              const InputDecoration(
                                                            label:
                                                                Text("titulo"),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _Changedstitle,
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "Descricao"),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _Changedtlimite,
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "dt_limite"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Atualizar'),
                                                      onPressed: () {
                                                        atualizarTask(
                                                            Task.id_atividade,
                                                            _Changedstitle
                                                                .text,
                                                            _Changedstitle.text,
                                                            _Changedtlimite
                                                                .text);
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Cancelar'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
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
                                            deletarTask(Task.id_atividade);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList() ??
                                [],
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
