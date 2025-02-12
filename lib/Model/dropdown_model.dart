import 'package:flutter/cupertino.dart';

class DropDownModel {
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  List<String> itemList;
  String name;
  String hintText;
  String? value;
  Widget? suffixWidget;
  DropDownModel(
      {required this.name,
      required this.itemList,
      this.suffixWidget,
      required this.hintText});
}
