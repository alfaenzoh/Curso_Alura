import 'package:flutter/material.dart';

import '../components/task.dart';

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
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'assets/images/bird.png',
                4),
            Task('Aprender Java',
                'assets/images/java.jpg', 3),
            Task(
                'Jogar',
                'assets/images/Valorant-Logo.png',
                2),
            Task(
                'Meditar',
                'assets/images/meditar.jpeg',
                1),
            Task(
                'Ler',
                'assets/images/book.jpg',
                5),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
