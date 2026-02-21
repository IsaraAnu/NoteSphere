import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;
  final List<Todo> completedTodos;
  const TodoTab({
    super.key,
    required this.incompletedTodos,
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  void _markAsDone(Todo todo) async {
    try {
      final updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await TodoService().markAsDone(updatedTodo);
      AppHelpers.showSnackBar(context, "Marked as Done");

      setState(() {
        widget.incompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTodo);
      });

      AppRouter.router.go("/todos");
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackBar(context, "Problem with Mark as Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.incompletedTodos.sort((a, b) => a.time.compareTo(b.time));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.incompletedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.incompletedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: false,
                  onCheckBoxChanged: () => _markAsDone(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
