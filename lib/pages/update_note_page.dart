import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;

  const UpdateNotePage({super.key, required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> categories = [];
  final NoteService noteServices = NoteService();

  //create a form key
  final _formKey = GlobalKey<FormState>();
  // text editing controllers
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  // string to store a category
  String selectedCategory = "";

  // dispose controllers
  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    selectedCategory = widget.note.category;
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note", style: AppTextStyles.appSubtitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // dropdown to select category
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a category";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        isExpanded: false,
                        hint: Text(selectedCategory),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                        ),

                        items: categories.map((String category) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            value: category,
                            child: Text(
                              category,
                              style: AppTextStyles.appButton,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                    // tittle textfield
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a title";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 2,
                      style: AppTextStyles.appSubtitle.copyWith(
                        fontSize: 30,
                        color: AppColors.kWhiteColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Note Title",
                        hintStyle: AppTextStyles.appSubtitle.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // note content textfield
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter note content";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 12,
                      style: AppTextStyles.appSubtitle.copyWith(
                        fontSize: 20,
                        color: AppColors.kWhiteColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Note Content",
                        hintStyle: AppTextStyles.appSubtitle.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              AppColors.kFabColor.withOpacity(0.95),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteServices.updateNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: selectedCategory,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.note.id,
                                  ),
                                );

                                // show snackbar
                                AppHelpers.showSnackBar(
                                  context,
                                  "Note updated successfully",
                                );
                                _noteTitleController.clear();
                                _noteContentController.clear();
                                AppRouter.router.push("/notes");
                              } catch (e) {
                                AppHelpers.showSnackBar(
                                  context,
                                  "Failed to update note",
                                );
                                print(e.toString());
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsetsGeometry.all(10),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
