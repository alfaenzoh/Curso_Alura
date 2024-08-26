import 'package:curso_1/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);


  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/bird.png', 4),
    Task('Aprender Java', 'assets/images/java.jpg', 3),
    Task('Jogar', 'assets/images/Valorant-Logo.png', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 1),
    Task('Ler', 'assets/images/book.jpg', 5),
  ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length ;
  }
}
