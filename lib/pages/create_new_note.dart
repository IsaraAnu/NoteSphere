import 'package:flutter/material.dart';

class CreateNewNote extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isNewCategory.toString())),
    );
  }
}
