import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> incompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.incompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  void _markAsUnDone(Todo todo) async {
    try {
      final updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      await TodoService().markAsUnDone(updatedTodo);
      AppHelpers.showSnackBar(context, "Mark as UnDone");

      setState(() {
        widget.completedTodos.remove(todo);
        widget.incompletedTodos.add(updatedTodo);
      });

      AppRouter.router.go("/todos");
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackBar(context, "Problem with Mark as UnDone");
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.completedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: true,
                  onCheckBoxChanged: () => _markAsUnDone(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
