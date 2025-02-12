import 'package:dealer_caryanam/Model/questions_model.dart';

class AboutUsModel {
  String title;
  String? descp;
  List<QuestionsModel>? list;
  AboutUsModel({required this.title, this.list, this.descp});
}
