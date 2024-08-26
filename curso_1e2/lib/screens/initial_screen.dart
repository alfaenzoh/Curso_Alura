import 'package:curso_1/data/task_inherited.dart';
import 'package:curso_1/screens/form_screen.dart';
import 'package:flutter/material.dart';


class InicialtScereen extends StatefulWidget {
  const InicialtScereen({super.key});

  @override
  State<InicialtScereen> createState() => _InicialtScereenState();
}

class _InicialtScereenState extends State<InicialtScereen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context,),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
