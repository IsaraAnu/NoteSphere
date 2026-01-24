import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/text_style.dart';

class NotesCategoryCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;

  final Future Function() removeNote;
  final Future Function() editNote;

  const NotesCategoryCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNote,
    required this.editNote,
  });

  @override
  State<NotesCategoryCard> createState() => _NotesCategoryCardState();
}

class _NotesCategoryCardState extends State<NotesCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.editNote,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: widget.removeNote,
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.noteTitle,
              style: AppTextStyles.appSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              widget.noteContent,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
