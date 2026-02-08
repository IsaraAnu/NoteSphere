import 'package:flutter/material.dart';
import 'package:note_sphere/utils/text_style.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("ToDo Tab", style: AppTextStyles.appSubtitle));
  }
}
