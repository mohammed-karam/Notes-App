import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/add_note_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/color_item.dart';
import 'package:notes_app/widgets/colors_list_view.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:notes_app/widgets/edit_note_colors_list_view.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Edit Note',
              icon: Icon(Icons.check),
              onPressed: () {
                widget.note.title = title ?? widget.note.title;
                widget.note.subTitle = subtitle ?? widget.note.subTitle;
                widget.note.save();
                Navigator.of(context).pop();
                BlocProvider.of<NoteCubit>(context).fetchAllNotes();
              },
            ),
            SizedBox(height: 32),
            CustomTextField(
              hint: widget.note.title,
              onChanged: (value) {
                title = value;
              },
            ),
            SizedBox(height: 32),
            CustomTextField(
              hint: widget.note.subTitle,
              maxLines: 5,
              onChanged: (value) {
                subtitle = value;
              },
            ),
            SizedBox(height: 60),
            EditNoteColorsList(note: widget.note),
          ],
        ),
      ),
    );
  }
}
