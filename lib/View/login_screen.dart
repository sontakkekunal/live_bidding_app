import 'dart:developer';
import 'dart:ui';

import 'package:dealer_caryanam/Controller/controller.dart';
import 'package:dealer_caryanam/Controller/shared_service.dart';
import 'package:dealer_caryanam/Model/registration_response_model.dart';
import 'package:dealer_caryanam/Model/textformfeild_model.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:dealer_caryanam/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constant/resizing.dart';
import 'get_start_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState {
  final List<TextFormFieldModel> _inputList = [
    TextFormFieldModel(
        name: 'Email',
        textColor: Colors.white,
        textInputType: TextInputType.emailAddress,
        autofillHintList: [AutofillHints.email],
        hintText: 'Email'),
    TextFormFieldModel(
        name: 'Pass',
        textColor: Colors.white,
        autofillHintList: [AutofillHints.password],
        textInputType: TextInputType.text,
        obsureText: true,
        provider: visibilityNotifierProvider,
        maxLines: 1,
        minLines: 1,
        hintText: 'Pass'),
  ];

  @override
  void dispose() {
    super.dispose();
    for (TextFormFieldModel inputmodel in _inputList) {
      inputmodel.editingController.dispose();
      inputmodel.globalKey.currentState?.dispose();
    }
  }

  @override
  void deactivate() {
    ref.invalidate(visibilityNotifierProvider);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    log("In build");
    _inputList[1].suffixWidget = getVisibilityIcon(
      passPos: 1,
      iconColor: Colors.white,
      ref: ref,
    );
    SizeConfig.init(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(
          title: 'Login',
          context: context,
          color: const Color(0xfff475f8a),
          fontColor: Colors.white),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_bg.jpg'),
              alignment: Alignment.center,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0.h()),
              margin: EdgeInsets.symmetric(horizontal: 20.0.w()),
              //height: 550.0.h(),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 6, spreadRadius: 4)
                  ]),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(color: Colors.white.withOpacity(0)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0.h()),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 100.0.h(),
                      //   width: 500.0.w(),
                      //   margin: EdgeInsets.symmetric(
                      //       horizontal: 20.0.w(), vertical: 20.0.h()),
                      //   decoration: BoxDecoration(
                      //       gradient: getGradient(),
                      //       borderRadius: BorderRadius.circular(20)),
                      //   alignment: Alignment.center,
                      //   child:
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children:
                            _inputList.map((TextFormFieldModel inputModel) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w(), vertical: 10.0.h()),
                              child:
                                  GetTextFormField(textFieldModel: inputModel));
                        }).toList(),
                      ),
                      SizedBox(
                        height: 15.0.h(),
                      ),
                      InkWell(
                        onTap: () async {
                          bool isDone = true;
                          for (int i = 0; i < _inputList.length; i++) {
                            if (!_inputList[i]
                                .globalKey
                                .currentState!
                                .validate()) {
                              isDone = false;
                            }
                          }
                          if (isDone) {
                            Map<String, dynamic> body = {
                              "username":
                                  _inputList[0].editingController.text.trim(),
                              "password":
                                  _inputList[1].editingController.text.trim()
                            };
                            showCircularProcess(context: context);
                            final dynamic response = await ref
                                .watch(apiProvider)
                                .loginCall(body: body);
                            Navigator.of(context).pop();
                            if (response != null) {
                              if (response.runtimeType == String) {
                                if (await SharedService.setLoginDetails(
                                    token: response)) {
                                  showSnackBar(
                                      color: Colors.green,
                                      message: "Login Successfully",
                                      context: context);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginManager()),
                                      (Route<dynamic> route) => false);

                                  // Navigator.of(context)
                                  //     .pushReplacementNamed('homeScreen');
                                } else {
                                  showSnackBar(
                                      color: Colors.red,
                                      message: "Please try again",
                                      context: context);
                                }
                              } else if (response.runtimeType ==
                                  RegistrationResponseModel) {
                                showSnackBar(
                                    color: Colors.red,
                                    message: response.message,
                                    context: context);
                              }
                            } else {
                              showSnackBar(
                                  color: Colors.red,
                                  message: "Something went wrong",
                                  context: context);
                            }
                          } else {
                            showSnackBar(
                                color: Colors.red,
                                message: "Please fill all fields properly",
                                context: context);
                          }
                        },
                        child: Container(
                          height: 50.0.h(),
                          width: 300.0.w(),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF5e67c7)
                              //gradient: getGradient(),
                              ),
                          child: const Text(
                            "Sign in",
                            //minFontSize: 5,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0.h(),
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Don't have an account?",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontFamily: 'Lato',
                      //         fontWeight: FontWeight.w400,
                      //         height: 0,
                      //       ),
                      //     ),
                      //     SizedBox(width: 6.0.w()),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.of(context)
                      //             .pushReplacementNamed('registrationScreen');
                      //       },
                      //       child: const Text(
                      //         "Sign up",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontFamily: 'Lato',
                      //           fontWeight: FontWeight.w500,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 8.0.h(),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed('forgetpassScreen');
                      //   },
                      //   child: const Text(
                      //     'Forget Password ?',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //       fontFamily: 'Lato',
                      //       fontWeight: FontWeight.w400,
                      //       height: 0,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.0.h(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
