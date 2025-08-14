import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/add_note_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/add_note_cubit/notes_states.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/colors_list_view.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({super.key});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  String? title, subtitle;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNotesCubit(),
      child: BlocConsumer<AddNotesCubit, AddNotesStates>(
        listener: (context, state) {
          if (state is AddNotesLoading) {
          } else if (state is AddNotesSuccess) {
            Navigator.of(context).pop();
            BlocProvider.of<NoteCubit>(context).fetchAllNotes();
          } else if (state is AddNotesFailure) {
            print(state.message);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddNotesLoading ? true : false,
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      CustomTextField(
                        hint: 'title',
                        onSaved: (value) {
                          title = value;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        hint: 'content',
                        maxLines: 5,
                        onSaved: (value) {
                          subtitle = value;
                        },
                      ),
                      SizedBox(height: 64),
                      ColorItemsList(),
                      SizedBox(height: 64),

                      CustomButton(
                        isLoading: state is AddNotesLoading ? true : false,
                        onTap: () {
                          onTapingButton(context);
                        },
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onTapingButton(BuildContext context) {
    var cubit = BlocProvider.of<AddNotesCubit>(context);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
    var currentDate = DateFormat.yMd().format(DateTime.now());
    cubit.addNote(
      NoteModel(
        title: title ?? '',
        subTitle: subtitle ?? '',
        date: currentDate,

        color: cubit.currentColor,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Note saved successfully!',
          style: TextStyle(fontSize: 20),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
      ),
    );
  }
}
