import 'package:flutter/material.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';
import 'package:note_sphere/widgets/notes_todo_card.dart';
import 'package:note_sphere/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteSphere", style: AppTextStyles.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 20),
            ProgressCard(completedTasks: 5, totalTasks: 10),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    title: "Notes",
                    description: "You have 12 notes",
                    icon: Icons.note_add_outlined,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: NotesTodoCard(
                    title: "To-Do",
                    description: "You have 8 tasks",
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress", style: AppTextStyles.appSubtitle),
                Text("See All", style: AppTextStyles.appButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
