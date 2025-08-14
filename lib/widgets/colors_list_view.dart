import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/add_note_cubit/notes_cubit.dart';
import 'package:notes_app/widgets/color_item.dart';

class ColorItemsList extends StatefulWidget {
  const ColorItemsList({super.key});

  @override
  State<ColorItemsList> createState() => _ColorItemsListState();
}

class _ColorItemsListState extends State<ColorItemsList> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2*38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentIndex = index;
              BlocProvider.of<AddNotesCubit>(context).currentColor = kColors[index].toARGB32();
              setState(() {});
            },
            child: ColorItem(
              color: kColors[index],
              isActive: currentIndex == index,
            ),
          );
        },
      ),
    );
  }
}
