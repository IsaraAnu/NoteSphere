import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/theme.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  //register adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  // open boxes
  await Hive.openBox("notes");
  await Hive.openBox("todos");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
