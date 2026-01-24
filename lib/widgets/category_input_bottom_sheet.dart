import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_style.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;
  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.kCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
        child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: widget.onNewNote,
              child: Row(
                children: [
                  Text("Create New Notes", style: AppTextStyles.appDescription),
                  Spacer(),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.5),
              thickness: 1,
            ),
            SizedBox(height: 30),

            GestureDetector(
              onTap: widget.onNewCategory,
              child: Row(
                children: [
                  Text(
                    "Create New Notes Category",
                    style: AppTextStyles.appDescription,
                  ),
                  Spacer(),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
