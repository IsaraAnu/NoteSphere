import 'package:flutter/material.dart';
import 'package:note_sphere/utils/text_style.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed Tab", style: AppTextStyles.appSubtitle),
    );
  }
}
