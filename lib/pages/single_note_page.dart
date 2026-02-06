import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_style.dart';

class SingleNotePage extends StatefulWidget {
  final Note note;
  const SingleNotePage({super.key, required this.note});

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    // formatted date
    final formattedDate = DateFormat().add_yMMMd().format(widget.note.date);
    return Scaffold(
      appBar: AppBar(title: Text("Note")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(widget.note.title, style: AppTextStyles.appTitle),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    formattedDate,
                    style: AppTextStyles.appBody.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.65),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    widget.note.category,
                    style: AppTextStyles.appBody.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.note.content,
                style: AppTextStyles.appDescription.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(0.95),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
