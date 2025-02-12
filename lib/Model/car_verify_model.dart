import 'package:flutter/cupertino.dart';

class CarVerifyModel {
  String name;
  String docMatch;
  List<CarPartModel> carPartList;
  CarVerifyModel(
      {required this.name, required this.carPartList, required this.docMatch});
}

class CarPartModel {
  String matchKey;
  String? docLink;
  int? docId;
  String? value;
  GlobalKey<FormFieldState> globalKey = GlobalKey<FormFieldState>();
  String name;
  List<String> options;

  CarPartModel(
      {required this.name, required this.matchKey, required this.options});
}
