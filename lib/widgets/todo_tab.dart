import 'package:flutter/material.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;
  const TodoTab({super.key, required this.incompletedTodos});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.incompletedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.incompletedTodos[index];
                return TodoCard(todo: todo, isCompleted: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
