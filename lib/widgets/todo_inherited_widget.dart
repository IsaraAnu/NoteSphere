import 'package:flutter/material.dart';
import 'package:note_sphere/models/todo_model.dart';

class TodoData extends InheritedWidget {
  final List<Todo> todos;
  final Function() onTodosChanged;

  TodoData({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodosChanged,
  });

  static TodoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }

  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    return todos != oldWidget.todos;
  }
}
