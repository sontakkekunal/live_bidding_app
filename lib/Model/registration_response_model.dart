import 'dart:developer';

class RegistrationResponseModel {
  late String code;
  late String message;

  RegistrationResponseModel({required this.code, required this.message});

  RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();

    message = json['message'];

    log("status code: $code \n message:$message");
  }
}
