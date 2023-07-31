import 'package:flutter/material.dart';
import 'package:hive_costom_data/static/color.dart';

// ignore: must_be_immutable
class CostomTextField extends StatelessWidget {
  CostomTextField(
      {super.key, required this.controller, required this.hintText});

  var hintText;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AllColors.blackColor),
        labelStyle: TextStyle(color: AllColors.blackColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.blackColor),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: AllColors.blueGreyColor)),
      ),
    );
  }
}
