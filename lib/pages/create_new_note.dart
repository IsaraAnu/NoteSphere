import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_style.dart';
import 'package:uuid/uuid.dart';

class CreateNewNote extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  List<String> categories = [];
  final NoteService noteServices = NoteService();

  //create a form key
  final _formKey = GlobalKey<FormState>();
  // text editing controllers
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  // string to store a category
  String selectedCategory = "";

  // dispose controllers
  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _noteCategoryController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note", style: AppTextStyles.appSubtitle),
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
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a category";
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
                              decoration: InputDecoration(
                                hintText: "New Category",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor.withOpacity(
                                      0.5,
                                    ),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor.withOpacity(
                                      0.5,
                                    ),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField<String>(
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
                              hint: const Text("Category"),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor.withOpacity(
                                      0.5,
                                    ),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor.withOpacity(
                                      0.5,
                                    ),
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
                            // save the notes
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteServices.addNewNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: widget.isNewCategory
                                        ? _noteCategoryController.text
                                        : selectedCategory,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: Uuid().v4(),
                                  ),
                                );

                                // show snackbar
                                AppHelpers.showSnackBar(
                                  context,
                                  "Note saved successfully!",
                                );

                                _noteTitleController.clear();
                                _noteContentController.clear();

                                AppRouter.router.push("/notes");
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e.toString());
                                  AppHelpers.showSnackBar(
                                    context,
                                    "Failed to save note!",
                                  );
                                }
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsetsGeometry.all(10),
                            child: Text(
                              "Save Note",
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
