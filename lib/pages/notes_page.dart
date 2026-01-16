import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _initializeNotes();
  }

  void _initializeNotes() async {
    bool isNewUser = await noteService.isNewUser();
    if (isNewUser) {
      await noteService.createInitialNotes();
    }
    // Load notes whether user is new or not
    await _loadNotes();
  }

  // method for loading notes
  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesByCategory = noteService
        .getNotesbyCategory(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
      print(notesWithCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //go to home page again
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(AppConstants.kDefaultPadding),
        child: Column(children: [Text("Notes", style: AppTextStyles.appTitle)]),
      ),
    );
  }
}
