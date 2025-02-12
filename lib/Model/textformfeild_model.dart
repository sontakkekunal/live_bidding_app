import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldModel {
  final String name;
  final String hintText;
  bool readOnly;
  final Iterable<String>? autofillHintList;
  final dynamic provider;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final bool obsureText;
  int maxLines;
  int minLines;
  final TextEditingController editingController = TextEditingController();
  final GlobalKey<FormFieldState> globalKey = GlobalKey();
  Color textColor;
  Widget? suffixWidget;
  Function? onTap;
  Function? onChange;
  DateTime? dateTime;
  String? extraVar;
  TextFormFieldModel(
      {required this.name,
      required this.textInputType,
      required this.hintText,
      this.textColor = Colors.black,
      this.inputFormatters,
      this.maxLines = 3,
      this.minLines = 1,
      this.obsureText = false,
      this.provider,
      this.onTap,
      this.readOnly = false,
      this.onChange,
      this.autofillHintList,
      this.suffixWidget});
}
