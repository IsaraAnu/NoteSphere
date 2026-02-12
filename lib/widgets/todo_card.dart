import 'package:flutter/material.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/text_style.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final bool isCompleted;
  const TodoCard({super.key, required this.todo, required this.isCompleted});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(widget.todo.title, style: AppTextStyles.appDescription),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${widget.todo.time.hour}:${widget.todo.time.minute}",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(value: widget.isCompleted, onChanged: (value) {}),
      ),
    );
  }
}
