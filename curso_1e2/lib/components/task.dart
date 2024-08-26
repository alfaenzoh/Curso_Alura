import 'package:curso_1/data/task_dao.dart';
import 'package:flutter/material.dart';

import './difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, this.nivel, {super.key});

  Task getTask() {
    return Task(nome, foto, dificuldade, nivel);
  }

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int levelColor = 0;
  double mastery = 0;
  final Map<int, Color> colorMap = {
    1: const Color.fromARGB(255, 154, 181, 48), // Verde oliva mais escuro
    2: const Color.fromARGB(255, 227, 121, 0), // Laranja queimado
    3: const Color.fromARGB(255, 204, 68, 0), // Laranja-avermelhado intenso
    4: const Color.fromARGB(255, 153, 0, 0), // Vermelho escuro profundo
    5: Colors.black,
  };

  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    mastery = (widget.nivel / widget.dificuldade) / 10;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: colorMap[levelColor] ?? Colors.blue),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        height: 100,
                        width: 72,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Difficulty(dificultyLevel: widget.dificuldade),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          // onLongPress: () {
                          //
                          //   TaskDao().delete(widget.nome);
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text('Deletando a Tarefa, Recarregue'),
                          //       behavior: SnackBarBehavior.floating,
                          //       elevation: 150.0,
                          //     ),
                          //   );
                          // },
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                              TaskDao().updateLevel(widget.getTask());
                            });
                            if (mastery >= 1) {
                              levelColor = widget.dificuldade;
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0) ? mastery : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
