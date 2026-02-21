import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';
import 'package:note_sphere/widgets/completed_tab.dart';
import 'package:note_sphere/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Todo> allTodos = [];
  late List<Todo> completedTodos = [];
  late List<Todo> inCompletedTodos = [];

  TodoService todoService = TodoService();

  TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createInizialTodos();
    }
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      // all todos
      allTodos = loadedTodos;
      // incompleted todos
      inCompletedTodos = allTodos.where((todo) => !todo.isDone).toList();
      // completed todos
      completedTodos = allTodos.where((todo) => todo.isDone).toList();
    });
  }

  // method to add task
  void _addTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        final Todo newTodo = Todo(
          title: _taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );
        await todoService.addNewTodo(newTodo);
        setState(() {
          inCompletedTodos.add(newTodo);
          allTodos.add(newTodo);
        });
        AppHelpers.showSnackBar(context, "Task added successfully!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackBar(context, "Failed to add task. Please try again.");
    }
  }

  // function about add a new todo
  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Add Task",
            style: AppTextStyles.appDescription.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.kWhiteColor,
            ),
          ),
          content: TextField(
            controller: _taskController,
            style: TextStyle(color: AppColors.kWhiteColor, fontSize: 20),
            decoration: InputDecoration(
              hintText: "Enter your task",
              hintStyle: AppTextStyles.appDescriptionSmall,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.kFabColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: const Text("Add Task", style: AppTextStyles.appButton),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.kWhiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text("ToDo", style: AppTextStyles.appDescription)),
            Tab(child: Text("Completed", style: AppTextStyles.appDescription)),
          ],
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMessageModel(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),

        child: Icon(Icons.add, size: 40, color: AppColors.kWhiteColor),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(
            incompletedTodos: inCompletedTodos,
            completedTodos: completedTodos,
          ),
          CompletedTab(
            completedTodos: completedTodos,
            incompletedTodos: inCompletedTodos,
          ),
        ],
      ),
    );
  }
}
