import 'package:hive/hive.dart';
import 'package:note_sphere/models/todo_model.dart';

class TodoService {
  // all todos
  List<Todo> todos = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  // create the database reference for todos
  final _myBox = Hive.box("todos");

  // check wheather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to create initial todos when use is new and box is empty
  Future<void> createInizialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  //method to load the todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }
}
