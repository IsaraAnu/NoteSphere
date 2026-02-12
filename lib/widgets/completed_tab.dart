import 'package:flutter/material.dart';
import 'package:note_sphere/models/todo_model.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  const CompletedTab({super.key, required this.completedTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {})),
        ],
      ),
    );
  }
}
