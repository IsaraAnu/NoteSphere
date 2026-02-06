import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';
import 'package:note_sphere/widgets/notes_category_card.dart';

class NotesByCategoryPage extends StatefulWidget {
  final String category;
  const NotesByCategoryPage({super.key, required this.category});

  @override
  State<NotesByCategoryPage> createState() => _NotesByCategoryPageState();
}

class _NotesByCategoryPageState extends State<NotesByCategoryPage> {
  //initialize the noteService
  final NoteService noteService = NoteService();
  List<Note> notesList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  // load all notes by category
  Future<void> _loadNotesByCategory() async {
    notesList = await noteService.getNotesByCategoryName(widget.category);
    setState(() {
      print(notesList.length);
    });
  }

  // edit note method
  void _editNote(Note note) {
    // navigate to update note page
    AppRouter.router.push("/edit-note", extra: note);
  }

  // delete note method
  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note deleted successfully");
      }
    } catch (e) {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Failed to delete note");
      }
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // go back to the note page
            AppRouter.router.push("/notes");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(widget.category, style: AppTextStyles.appTitle),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  return NotesCategoryCard(
                    viewSingleNote: () {
                      AppRouter.router.push(
                        "/single-note",
                        extra: notesList[index],
                      );
                    },
                    noteTitle: notesList[index].title,
                    noteContent: notesList[index].content,
                    editNote: () async {
                      _editNote(notesList[index]);
                    },

                    removeNote: () async {
                      await _removeNote(notesList[index].id);
                      setState(() {
                        notesList.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
