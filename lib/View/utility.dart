import 'dart:io';

import 'package:dealer_caryanam/Constant/resizing.dart';
import 'package:dealer_caryanam/Controller/controller.dart';
import 'package:dealer_caryanam/Model/textformfeild_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Model/dropdown_model.dart';

void showSnackBar(
    {required Color color,
    required String message,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.white),
    )),
    duration: const Duration(milliseconds: 1750),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
  ));
}

AppBar getAppBar(
    {required String title,
    Color? color,
    required BuildContext context,
    Color fontColor = Colors.white}) {
  return AppBar(
    toolbarHeight: 60.0.h(),
    backgroundColor: color ?? Theme.of(context).appBarTheme.backgroundColor,
    leadingWidth: 60.0.w(),
    centerTitle: true,
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.w600, color: fontColor),
    ),
    leading:
        Padding(padding: EdgeInsets.only(left: 15.0.w()), child: getLogo()),
  );
}

Widget getLogo() {
  return Image.asset(
    'assets/logo_img/cartechlogo2.png',
    height: 40.0.h(),
    width: 40.0.w(),
  );
}

void showCircularProcess({required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 7.0.h(),
            color: const Color(0xFF232323),
          ),
        );
      });
}

Widget getVisibilityIcon(
    {required int passPos,
    required WidgetRef ref,
    Color iconColor = Colors.black}) {
  return Consumer(builder: (context, ref, child) {
    bool val;
    if (passPos == 1) {
      val = ref.watch(visibilityNotifierProvider);
    } else {
      val = ref.watch(visibilityNotifier2Provider);
    }

    return IconButton(
        color: iconColor,
        onPressed: () {
          if (passPos == 1) {
            ref.read(visibilityNotifierProvider.notifier).change();
          } else {
            ref.read(visibilityNotifier2Provider.notifier).change();
          }
        },
        icon: Icon(
            !val ? Icons.visibility_outlined : Icons.visibility_off_outlined));
  });
}

final List<BoxShadow> boxShadow1 = [
  BoxShadow(color: Colors.black12, spreadRadius: 3.0.h(), blurRadius: 5.0.h())
];
Future<File?> addImg({required BuildContext context}) async {
  try {
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (filePickerResult != null) {
      File file = File(filePickerResult.files.first.path!);
      return file;
    }
  } catch (e) {
    showSnackBar(
        color: Colors.red, message: 'Something went wrong', context: context);
  }
  return null;
}

InputDecoration getInputDecoration2(
    {required final DropDownModel dropdownmodel,
    required final BuildContext context}) {
  return InputDecoration(
      suffixIcon: dropdownmodel.suffixWidget,
      contentPadding: EdgeInsets.only(
          top: 13.0.h(), bottom: 13.0.h(), left: 22.0.w(), right: 15.0.w()),
      labelText: dropdownmodel.name,
      hintStyle: Theme.of(context).textTheme.titleSmall,
      hintText: dropdownmodel.hintText,
      labelStyle: Theme.of(context).textTheme.titleSmall,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: const BorderSide(color: Colors.black38, width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: const BorderSide(color: Colors.red, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: const BorderSide(color: Colors.black38, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: const BorderSide(color: Colors.red, width: 2)));
}

void getFlutterToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;
  int seconds = duration.inSeconds % 60;

  String result = '';

  if (hours > 0) {
    result += '$hours H: ';
  }

  if (minutes > 0 || hours > 0) {
    result += '$minutes M: ';
  }

  result += '$seconds S';

  return result;
}

DateTime normalDateTime({required String date}) {
  return DateTime.parse(date);
}

final String noCarImg = 'https://www.carxstream.in/images/nocar.jpg';

class GetTextFormField extends ConsumerWidget {
  final TextFormFieldModel textFieldModel;
  final String? prepass;
  //final FocusNode? focusNode;
  const GetTextFormField({
    super.key,
    required this.textFieldModel,
    this.prepass,
    //this.focusNode
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    return TextFormField(
      //focusNode: focusNode,
      onTap: () {
        if (textFieldModel.onTap != null) {
          textFieldModel.onTap!();
        }
      },
      onChanged: (String val) {
        if (textFieldModel.onChange != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            textFieldModel.onChange!();
          });
        }
      },
      readOnly: textFieldModel.readOnly,
      obscureText: textFieldModel.obsureText
          ? ref.watch(textFieldModel.provider)
          : false,
      inputFormatters: textFieldModel.inputFormatters,
      maxLines: textFieldModel.maxLines,
      autofillHints: textFieldModel.autofillHintList,
      minLines: textFieldModel.minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: textFieldModel.globalKey,
      controller: textFieldModel.editingController,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: textFieldModel.textColor),
      keyboardType: textFieldModel.textInputType,
      validator: (String? val) {
        if (textFieldModel.textInputType == TextInputType.name ||
            textFieldModel.textInputType == TextInputType.phone) {
          if ((val == null || val.isEmpty) || val.trim().isEmpty) {
            return "Please enter ${textFieldModel.name}";
          } else if ((textFieldModel.name == 'First Name' ||
                  textFieldModel.name == 'Last Name') &&
              !isName(name: val.trim())) {
            return "Please enter valid ${textFieldModel.name}";
          } else if (textFieldModel.name == 'Name' &&
              !isText(val: val.trim())) {
            return "Please enter valid name";
          } else if (textFieldModel.textInputType == TextInputType.phone &&
              val.length != 10) {
            return "Please enter valid ${textFieldModel.name}";
          }
        } else if (textFieldModel.textInputType == TextInputType.emailAddress) {
          if (val != null && !EmailValidator.validate(val)) {
            return "Please enter valid email";
          }
        } else if (textFieldModel.textInputType == TextInputType.text) {
          if (prepass != null &&
              textFieldModel.name == 'Confirm Password' &&
              prepass != val) {
            return "Password not match";
          } else {
            if (val == null || val.isEmpty) {
              return "Please enter valid password";
            } else if (val.contains(' ')) {
              return "Space not allowed in password";
            } else if (textFieldModel.name.contains('Password') &&
                !checkPass(val, ref.watch(passValueProvider))) {
              return "";
            }
          }
        }
        if (val == null || val.isEmpty) {
          return 'Please enter valid ${textFieldModel.name}';
        }

        return null;
      },
      decoration:
          getInputDecoration(textfieldModel: textFieldModel, context: context),
    );
  }
}

bool isName({required String name}) {
  for (int i = 0; i < name.length; i++) {
    int ascii = name.codeUnitAt(i);
    if (!((ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122))) {
      return false;
    }
  }
  return true;
}

bool isText({required String val}) {
  for (int i = 0; i < val.length; i++) {
    int ascii = val.codeUnitAt(i);
    if (ascii != 32 &&
        !((ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122))) {
      return false;
    }
  }
  return true;
}

InputDecoration getInputDecoration(
    {required final TextFormFieldModel textfieldModel,
    required final BuildContext context}) {
  return InputDecoration(
      suffixIcon: textfieldModel.suffixWidget,
      contentPadding: EdgeInsets.only(
          top: 13.0.h(), bottom: 13.0.h(), left: 22.0.w(), right: 15.0.w()),
      labelText: "Enter your ${textfieldModel.name}",
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: textfieldModel.textColor),
      hintText: textfieldModel.hintText,
      labelStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: textfieldModel.textColor),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: BorderSide(
              color: textfieldModel.textColor == Colors.black
                  ? Colors.black38
                  : textfieldModel.textColor,
              width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: BorderSide(
              color: textfieldModel.textColor == Colors.black
                  ? Colors.black38
                  : textfieldModel.textColor,
              width: 2)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: BorderSide(
              color: textfieldModel.textColor == Colors.black
                  ? Colors.black38
                  : textfieldModel.textColor,
              width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.h()),
          borderSide: BorderSide(
              color: textfieldModel.textColor == Colors.black
                  ? Colors.black38
                  : textfieldModel.textColor,
              width: 2)));
}
