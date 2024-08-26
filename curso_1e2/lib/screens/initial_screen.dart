import 'package:curso_1/data/task_dao.dart';
import 'package:curso_1/screens/form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/task.dart';
import '../components/confirm_alert.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                setState(() => {});
              },
              icon: const Icon(Icons.refresh)),
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() => {});
                        }, //2 jeitos de fazer o refresh
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task tarefa = items[index];
                              return Dismissible(
                                key: Key(tarefa.nome),
                                direction: DismissDirection.startToEnd,
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(
                                      CupertinoIcons.trash_circle_fill,
                                      size: 80,
                                      color: Colors.white),
                                ),
                                confirmDismiss: (direction) async {
                                  return await showDeleteConfirmationDialog(
                                      context);
                                },
                                onDismissed: (direction) {
                                  setState(() {
                                    TaskDao().delete(tarefa.nome);
                                    items.removeAt(index);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${tarefa.nome} deletada'),
                                    ),
                                  );
                                },
                                child: tarefa,
                              );
                            }),
                      );
                    }
                    return Center(
                      child: Column(
                        children: const [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não há nenhuma tarefa',
                            style: TextStyle(fontSize: 32),
                          )
                        ],
                      ),
                    );
                  }
                  return const Text(' Erro ao carregar tarefas');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(() => {print('Carregado a Janela')}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
