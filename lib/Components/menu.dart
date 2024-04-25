import 'package:flutter/material.dart';
import 'package:opt120/Screens/task_screen.dart';
import 'package:opt120/Screens/user_screen.dart';
import 'package:opt120/Screens/user_task_screen.dart';
import '../Screens/home_screen.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
          children: [
            ListTile(
            leading: const Icon(Icons.home),
            title: Text("Home"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
            },
          ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Criar usuário"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pending_actions),
              title: Text("Criar atividade"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: Text("Usuários que fizeram as atividades"),
              onTap: (){
                //Navigator.push(context,
                    //MaterialPageRoute(builder: (context) => UserTaskScreen()));
              },
            ),
          ],
      ),
    );
  }
}
