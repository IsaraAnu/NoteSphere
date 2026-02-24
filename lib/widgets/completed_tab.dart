import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';
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
  // Text Controller එකක් ඕනේ වෙනවා Edit කරන්න
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // Done කරපු එක ආයෙත් UnDone කරන්න
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
      AppHelpers.showSnackBar(context, "Marked as UnDone");

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

  // Delete කරන ලොජික් එක
  void _deleteTodo(Todo todo) async {
    try {
      await TodoService().deleteTodo(todo);
      setState(() {
        widget.completedTodos.remove(todo);
      });
      AppHelpers.showSnackBar(context, "Completed Todo Deleted");
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackBar(context, "Error deleting todo");
    }
  }

  // Edit සේව් කරන ලොජික් එක
  void _saveEditTodo(Todo todo) async {
    try {
      if (_taskController.text.isNotEmpty) {
        // අලුත් ටයිටල් එකත් එක්ක අලුත් ඔබ්ජෙක්ට් එකක් හදනවා
        final updatedTodo = Todo(
          id: todo.id,
          title: _taskController.text,
          date: todo.date,
          time: todo.time,
          isDone: todo.isDone,
        );

        await TodoService().editTodo(updatedTodo);

        setState(() {
          // ලිස්ට් එකේ තියෙන පරණ එක වෙනුවට අලුත් එක දානවා
          int index = widget.completedTodos.indexOf(todo);
          if (index != -1) {
            widget.completedTodos[index] = updatedTodo;
          }
        });

        AppHelpers.showSnackBar(context, "Task updated successfully!");
        Navigator.of(context).pop();
        _taskController.clear();
      }
    } catch (e) {
      AppHelpers.showSnackBar(context, "Error updating task");
    }
  }

  // Edit Dialog එක
  void openMessageModel(BuildContext context, Todo todo) {
    _taskController.text = todo.title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Edit Completed Task",
            style: AppTextStyles.appDescription.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.kWhiteColor,
            ),
          ),
          content: TextField(
            controller: _taskController,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: "Update your task",
              hintStyle: AppTextStyles.appDescriptionSmall,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.kWhiteColor),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => _saveEditTodo(todo),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kFabColor,
              ),
              child: const Text("Save", style: AppTextStyles.appButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.completedTodos[index];

                return Dismissible(
                  key: Key(todo.id.toString()),

                  // වමේ ඉඳන් දකුණට -> Edit (කොළ පාට)
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),

                  // දකුණේ ඉඳන් වමට -> Delete (රතු පාට)
                  secondaryBackground: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  // Swipe කරනකොට ක්‍රියාත්මක වන ලොජික් එක
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Edit Dialog එක පෙන්වනවා
                      openMessageModel(context, todo);
                      return false; // ලිස්ට් එකෙන් අයින් වෙන්න දෙන්න එපා
                    } else {
                      // Delete කරනවා
                      _deleteTodo(todo);
                      return true; // ලිස්ට් එකෙන් අයින් වෙන්න දෙන්න
                    }
                  },

                  child: TodoCard(
                    todo: todo,
                    isCompleted: true,
                    onCheckBoxChanged: () => _markAsUnDone(todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
