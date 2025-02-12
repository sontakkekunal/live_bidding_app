import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealer_caryanam/Constant/resizing.dart';
import 'package:dealer_caryanam/Model/live_bid_model.dart';
import 'package:dealer_caryanam/Model/textformfeild_model.dart';
import 'package:dealer_caryanam/Model/vehicle_bidding_info_model.dart';
import 'package:dealer_caryanam/View/inspector_car_verification_screen.dart';
import 'package:dealer_caryanam/View/inspector_report_screen.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../Controller/controller.dart';
import '../Model/token_model.dart';
import '../Model/vehicle_model.dart';

class VehicleDetailsScreen extends ConsumerStatefulWidget {
  final VehicleModel vehicleModel;
  final TokenModel tokenModel;
  final int? beadingId;
  final VehicleBiddingInfoModel? vbim;
  const VehicleDetailsScreen(
      {super.key,
      required this.vehicleModel,
      required this.tokenModel,
      this.beadingId,
      this.vbim});

  @override
  ConsumerState createState() {
    return _VehicleDetailsScreenState();
  }
}

class _VehicleDetailsScreenState extends ConsumerState<VehicleDetailsScreen> {
  int _activeIndex = 0;
  final TextEditingController _priceController = TextEditingController();
  final GlobalKey<FormFieldState> _priceGlobalKey = GlobalKey<FormFieldState>();
  Timer? _amountTimer;
  int _amount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.vbim != null) {
      _amountTimer = Timer.periodic(Duration(seconds: 1), (time) async {
        await _updatedAmount();
      });
    }
    //if (widget.vehicleModel.carId != null) {}
  }

  @override
  void dispose() {
    super.dispose();

    //_priceGlobalKey.currentState!.dispose();
    _priceController.dispose();
    _amountTimer?.cancel();
  }

  final TextFormFieldModel _bidTextModel = TextFormFieldModel(
      name: "Place Bid",
      readOnly: true,
      textInputType: TextInputType.number,
      hintText: "Place bid",
      inputFormatters: [FilteringTextInputFormatter.digitsOnly]);

  Future<void> _updatedAmount() async {
    // VehicleBiddingInfoModel? vbim = await ref
    //     .watch(apiProvider)
    //     .biddingLiveCarSpecfic(id: widget.vehicleModel.beadingCarId);
    if (widget.vbim != null) {
      LiveBidModel? val =
          await ref.watch(apiProvider).bidCarById(id: widget.vbim!.bidCarId);
      print(val);
      if (val != null) {
        _amount = val.amount;
      } else {
        _amount = widget.vbim!.basePrice;
      }
    }
    ref.read(refresh2Provider.notifier).increment();
  }

  Future<void> _showPlacingBidCar() async {
    await _updatedAmount();
    _bidTextModel.editingController.text = _amount.toString();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Place bid'),
            content: SizedBox(
              width: 350.0.w(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        int val = int.parse(
                            _bidTextModel.editingController.text.trim());
                        val = val + 2000;
                        _bidTextModel.editingController.text = val.toString();
                      },
                      icon: Icon(Icons.add_circle_outline_outlined)),
                  SizedBox(
                      width: 175.0.w(),
                      child: GetTextFormField(textFieldModel: _bidTextModel)),
                  Consumer(builder: (context, ref, child) {
                    ref.watch(refresh2Provider);
                    print(_bidTextModel.editingController.text.trim());
                    String strVal = _bidTextModel.editingController.text.trim();
                    int amount2 =
                        int.parse(strVal.isEmpty ? "$_amount" : strVal);
                    bool cnd = amount2 - 200 <= _amount;
                    return IconButton(
                        onPressed: cnd
                            ? () {}
                            : () {
                                int val = int.parse(_bidTextModel
                                    .editingController.text
                                    .trim());
                                if (val > 0) {
                                  val = val - 2000;
                                  _bidTextModel.editingController.text =
                                      val.toString();
                                }
                              },
                        icon: Icon(
                          Icons.remove_circle_outline_outlined,
                          color: cnd ? Colors.grey.shade700 : Colors.black,
                        ));
                  })
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              InkWell(
                onTap: () async {
                  int amount2 =
                      int.parse(_bidTextModel.editingController.text.trim());
                  if (amount2 <= _amount) {
                    getFlutterToast(message: "Please amount higher amount");
                    return;
                  }
                  Map<String, dynamic> map = {
                    "userId": widget.vehicleModel.userId,
                    "bidCarId": widget.vehicleModel.beadingCarId,
                    "dateTime": DateTime.now().toIso8601String(),
                    "amount": _bidTextModel.editingController.text.trim()
                  };

                  showCircularProcess(context: context);
                  bool val = await ref.watch(apiProvider).placeBid(
                      token: widget.tokenModel.originalToken,
                      body: map,
                      bidCarId: widget.vbim!.bidCarId);

                  Navigator.of(context).pop();
                  if (val) {
                    Navigator.of(context).pop();
                    showSnackBar(
                        color: Colors.green,
                        message: "Bid Placed Successfully",
                        context: context);
                  } else {
                    showSnackBar(
                        color: Colors.red,
                        message: "Bid Placed Unsuccessfully",
                        context: context);
                  }
                },
                child: Container(
                  height: 40.0.h(),
                  width: 80.0.w(),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                      boxShadow: boxShadow1),
                  alignment: Alignment.center,
                  child: Text(
                    "Place",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    log("In build");

    VehicleModel vehicleDataModel = widget.vehicleModel;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final style1 = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w600);
    final headStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontWeight: FontWeight.w600);
    final style2 = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CarouselSlider.builder(
                    itemCount: vehicleDataModel.imgInfoList != null
                        ? vehicleDataModel.imgInfoList?.length
                        : 1,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    vehicleDataModel.imgInfoList != null
                                        ? vehicleDataModel
                                            .imgInfoList![index].documentLink
                                        : noCarImg))),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (int index, reason) {
                        _activeIndex = index;
                        ref.read(refreshProvider.notifier).increment();
                      },
                      height: 220.0.h(),
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      //autoPlay: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      enlargeFactor: 0.55,
                      enlargeCenterPage: true,
                    )),
                if (vehicleDataModel.imgInfoList != null)
                  Positioned(
                      top: 15.0.h(),
                      right: 20.0.w(),
                      child: Container(
                        height: 22.5.h(),
                        width: 45.0.w(),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10.0.h())),
                        child: Consumer(builder: (context, ref, child) {
                          ref.watch(refreshProvider);
                          log("On consumer");
                          return Text(
                            "${_activeIndex + 1}/${vehicleDataModel.imgInfoList!.length}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          );
                        }),
                      ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 25.0.w(), vertical: 15.0.h()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0.h(),
                  ),
                  Text(
                    '${vehicleDataModel.brand} ${vehicleDataModel.model}',
                    style: headStyle,
                  ),
                  // SizedBox(
                  //   height: 10.0.h(),
                  // ),
                  //
                  // Text(
                  //   '₹ ${vehicleDataModel.price}',
                  //   style: headStyle.copyWith(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 25.0.h()),
                  // ),
                  SizedBox(
                    height: 10.0.h(),
                  ),

                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(
                        vertical: 3.5.h(), horizontal: 7.5.w()),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 3.0.h(),
                            blurRadius: 5.0.h())
                      ],
                      borderRadius: BorderRadius.circular(10.0.h()),
                      // border:
                      //     Border.all(color: Colors.black, width: 1.0.h())
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Top Features',
                          style: headStyle.copyWith(
                              decoration: TextDecoration.underline),
                        ),
                        // Column(
                        //   children: vehicleDataModel
                        //       .getCarTopFeatures()
                        //       .map((element) {
                        //     return Padding(
                        //       padding: EdgeInsets.symmetric(vertical: 7.0.h()),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Icon(element.extraVar, color: Colors.green),
                        //           SizedBox(
                        //             width: 7.0.w(),
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               element.question,
                        //               style: style2,
                        //               textAlign: TextAlign.justify,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                        Column(
                          children:
                              vehicleDataModel.getTopFeatures().map((element) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.8.h()),
                              child: (element.length == 2)
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.0.w(),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(element[0].extraVar,
                                                  color: Colors.green),
                                              SizedBox(
                                                width: 7.0.w(),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  element[0].question,
                                                  style: style2!.copyWith(
                                                      fontSize: 15.0.h()),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0.w(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.centerLeft,
                                          width: 150.0.w(),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                element[1].extraVar,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 7.0.w(),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  element[1].question,
                                                  style: style2!.copyWith(
                                                      fontSize: 15.0.h()),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: 150.0.w(),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(element[0].extraVar,
                                                color: Colors.green),
                                            SizedBox(
                                              width: 7.0.w(),
                                            ),
                                            Expanded(
                                              child: Text(
                                                element[0].question,
                                                style: style2!.copyWith(
                                                    fontSize: 15.0.h()),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    // child: Column(
                    //   children:
                    //       vehicleDataModel.getTopFeatures().map((element) {
                    //     return Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 6.8.h()),
                    //       child: (element.length == 2)
                    //           ? Row(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 SizedBox(
                    //                   width: 150.0.w(),
                    //                   child: Row(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Icon(element[0].extraVar,
                    //                           color: Colors.green),
                    //                       SizedBox(
                    //                         width: 7.0.w(),
                    //                       ),
                    //                       Expanded(
                    //                         child: Text(
                    //                           element[0].question,
                    //                           style: style2,
                    //                           textAlign: TextAlign.justify,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 20.0.w(),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 100.0.w(),
                    //                   child: Row(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Icon(
                    //                         element[1].extraVar,
                    //                         color: Colors.green,
                    //                       ),
                    //                       SizedBox(
                    //                         width: 7.0.w(),
                    //                       ),
                    //                       Expanded(
                    //                         child: Text(
                    //                           element[1].question,
                    //                           style: style2,
                    //                           textAlign: TextAlign.justify,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             )
                    //           : Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: SizedBox(
                    //                 width: 150.0.w(),
                    //                 child: Row(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Icon(element[0].extraVar,
                    //                         color: Colors.green),
                    //                     SizedBox(
                    //                       width: 7.0.w(),
                    //                     ),
                    //                     Expanded(
                    //                       child: Text(
                    //                         element[0].question,
                    //                         style: style2,
                    //                         textAlign: TextAlign.justify,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //     );
                    //   }).toList(),
                    // ),
                  ),
                  // Column(
                  //   children: vehicleDataModel.getTopFeatures().map((element) {
                  //     return Padding(
                  //       padding: EdgeInsets.symmetric(vertical: 6.8.h()),
                  //       child: (element.length == 2)
                  //           ? Row(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Expanded(
                  //                   child: Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 5.0.w(),
                  //                         vertical: 2.0.h()),
                  //                     alignment: Alignment.center,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.grey[350],
                  //                         borderRadius:
                  //                             BorderRadius.circular(5.0.h())),
                  //                     child: Text(
                  //                       element[0],
                  //                       style: style2,
                  //                       textAlign: TextAlign.justify,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 20.0.w(),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 5.0.w(),
                  //                         vertical: 2.0.h()),
                  //                     alignment: Alignment.center,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.grey[350],
                  //                         borderRadius:
                  //                             BorderRadius.circular(5.0.h())),
                  //                     child: Text(
                  //                       element[1],
                  //                       style: style2,
                  //                       textAlign: TextAlign.justify,
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             )
                  //           : Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: 5.0.w(), vertical: 2.0.h()),
                  //                   alignment: Alignment.center,
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.grey[350],
                  //                       borderRadius:
                  //                           BorderRadius.circular(5.0.h())),
                  //                   child: Text(
                  //                     element[0],
                  //                     style: style2,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //     );
                  //   }).toList(),
                  // ),

                  SizedBox(
                    height: 20.0.h(),
                  ),

                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(
                        vertical: 3.5.h(), horizontal: 7.5.w()),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 3.0.h(),
                            blurRadius: 5.0.h())
                      ],
                      borderRadius: BorderRadius.circular(10.0.h()),
                      // border:
                      //     Border.all(color: Colors.black, width: 1.0.h()
                      //     )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Know your Car',
                          style: headStyle.copyWith(
                              decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          height: 10.0.h(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              vehicleDataModel.getKnowCarList().map((element) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0.h(), horizontal: 5.0.w()),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        element.extraVar,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 5.0.w(),
                                      ),
                                      SizedBox(
                                        child: Text(element.question,
                                            style: style1.copyWith(
                                                color: Colors.black45,
                                                fontSize: 15.0.h())),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      width: 160.0.w(),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        element.answer,
                                        style: style2!.copyWith(
                                          fontSize: 15.0.h(),
                                        ),
                                        textAlign: TextAlign.right,
                                      ))
                                ],
                              ),
                              // child: RichText(
                              //     textAlign: TextAlign.justify,
                              //     text: TextSpan(children: [
                              //       TextSpan(
                              //           text: element.question, style: style1),
                              //       TextSpan(
                              //           text: element.answer, style: style2)
                              //     ])),
                            );
                            // return Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 5.0.h()),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       RichText(
                            //           text: TextSpan(children: [
                            //         TextSpan(
                            //           text: element[0],
                            //           style: style1,
                            //         ),
                            //         TextSpan(text: element[1], style: style2)
                            //       ])),
                            //       const Spacer(),
                            //       Expanded(
                            //         child: RichText(
                            //             text: TextSpan(children: [
                            //           TextSpan(
                            //             text: element[2],
                            //             style: style1,
                            //           ),
                            //           TextSpan(text: element[3], style: style2)
                            //         ])),
                            //       )
                            //     ],
                            //   ),
                            // );
                          }).toList(),
                        ),
                        if (vehicleDataModel.carInsurance == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w()),
                            height: 30.0.h(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.security,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 7.0.w(),
                                    ),
                                    Text(
                                      'Insurance Type: ',
                                      style: style1!.copyWith(
                                          color: Colors.black45,
                                          fontSize: 15.0.h()),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150.0.w(),
                                  alignment: Alignment.centerRight,
                                  child: Text(vehicleDataModel.carInsuranceType,
                                      style:
                                          style2!.copyWith(fontSize: 15.0.h())),
                                )
                              ],
                            ),
                            // child: RichText(
                            //     text: TextSpan(children: [
                            //   TextSpan(
                            //     text: 'Insurance Type: ',
                            //     style: style1,
                            //   ),
                            //   TextSpan(
                            //       text: vehicleDataModel.carInsuranceType,
                            //       style: style2)
                            // ])),
                          )
                      ],
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     RichText(
                  //         text: TextSpan(children: [
                  //       TextSpan(
                  //         text: 'Reg Num: ',
                  //         style: style1,
                  //       ),
                  //       TextSpan(
                  //           text: vehicleDataModel.registration, style: style2)
                  //     ])),
                  //     const Spacer(),
                  //     Expanded(
                  //       child: RichText(
                  //           text: TextSpan(children: [
                  //         TextSpan(
                  //           text: 'Make year: ',
                  //           style: style1,
                  //         ),
                  //         TextSpan(
                  //             text: vehicleDataModel.year.toString(),
                  //             style: style2)
                  //       ])),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     RichText(
                  //         text: TextSpan(children: [
                  //       TextSpan(
                  //         text: 'Fuel Type: ',
                  //         style: style1,
                  //       ),
                  //       TextSpan(text: vehicleDataModel.fuelType, style: style2)
                  //     ])),
                  //     const Spacer(),
                  //     Expanded(
                  //       child: RichText(
                  //           text: TextSpan(children: [
                  //         TextSpan(
                  //           text: 'Transmission: ',
                  //           style: style1,
                  //         ),
                  //         TextSpan(
                  //             text: vehicleDataModel.transmission,
                  //             style: style2)
                  //       ])),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     RichText(
                  //         text: TextSpan(children: [
                  //       TextSpan(
                  //         text: 'KM Driven: ',
                  //         style: style1,
                  //       ),
                  //       TextSpan(
                  //           text: "${vehicleDataModel.kmDriven} km",
                  //           style: style2)
                  //     ])),
                  //     const Spacer(),
                  //     Expanded(
                  //       child: RichText(
                  //           text: TextSpan(children: [
                  //         TextSpan(
                  //           text: 'Ownership: ',
                  //           style: style1,
                  //         ),
                  //         TextSpan(
                  //             text: vehicleDataModel.ownerSerial.toString(),
                  //             style: style2)
                  //       ])),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     RichText(
                  //         text: TextSpan(children: [
                  //       TextSpan(
                  //         text: 'Date: ',
                  //         style: style1,
                  //       ),
                  //       TextSpan(text: vehicleDataModel.date, style: style2)
                  //     ])),
                  //     const Spacer(),
                  //     Expanded(
                  //       child: RichText(
                  //           text: TextSpan(children: [
                  //         TextSpan(
                  //           text: 'Parked At: ',
                  //           style: style1,
                  //         ),
                  //         TextSpan(
                  //             text:
                  //                 "${vehicleDataModel.area} , ${vehicleDataModel.city}",
                  //             style: style2)
                  //       ])),
                  //     )
                  //   ],
                  // ),

                  SizedBox(
                    height: 10.0.h(),
                  ),
                  // Text(
                  //   'Top Features',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .titleLarge!
                  //       .copyWith(fontWeight: FontWeight.w600),
                  // ),

                  SizedBox(
                    height: 10.0.h(),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return InspectorReportScreen(
                              beadingId: widget.vehicleModel.beadingCarId);
                          return InspectorCarVerificationScreen(
                              beadingId: widget.vehicleModel.beadingCarId,
                              token: widget.tokenModel);
                        }));
                      },
                      child: Text(
                        "View Inspector Report",
                        style: TextStyle(color: Colors.green),
                      )),
                  SizedBox(
                    height: 10.0.h(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ',
                        style: style1,
                      ),
                      Text(
                        vehicleDataModel.description,
                        style: style2!.copyWith(fontSize: 15.0.h()),
                      )
                    ],
                  ),
                  SizedBox(
                    height: widget.vbim != null ? 100.0.h() : 60.0.h(),
                  ),
                  //if (vehicleDataModel.carId != null)
                  // Text(
                  //   'Dealer Contact:',
                  //   style: style1,
                  // ),
                  // SizedBox(
                  //   height: 10.0.h(),
                  // ),
                  // if (vehicleDataModel.carId != null)
                  //   ref.watch(dealerProvider).when(data: (DealerModel data) {
                  //     return Container(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: 4.0.h(), horizontal: 8.0.w()),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.black12,
                  //               spreadRadius: 3.0.h(),
                  //               blurRadius: 5.0.h())
                  //         ],
                  //         borderRadius: BorderRadius.circular(10.0.h()),
                  //         // border: Border.all(
                  //         //     color: Colors.black, width: 1.0.h())
                  //       ),
                  //       child: Column(
                  //           children: data.getShortList().map((element) {
                  //         return Padding(
                  //           padding: EdgeInsets.symmetric(
                  //             vertical: 5.0.h(),
                  //           ),
                  //           child: Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 element.question,
                  //                 style: style1!.copyWith(fontSize: 15.0.h()),
                  //               ),
                  //               Expanded(
                  //                 child: Text(
                  //                   element.answer,
                  //                   textAlign: TextAlign.justify,
                  //                   style: style2!.copyWith(fontSize: 15.0.h()),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }).toList()),
                  //     );
                  //   }, error: (user, error) {
                  //     return Text(
                  //       user.toString(),
                  //       style: style2,
                  //     );
                  //   }, loading: () {
                  //     return const Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   }),
                  // if (widget.tokenModel == null ||
                  //     (widget.tokenModel != null &&
                  //         widget.tokenModel!.isUser()))
                  //   Center(
                  //     child: InkWell(
                  //       onTap: () async {
                  //
                  //       },
                  //       child: Container(
                  //         height: 50.0.h(),
                  //         width: 150.0.w(),
                  //         margin: EdgeInsets.symmetric(vertical: 20.0.h()),
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             gradient: const LinearGradient(
                  //                 colors: [
                  //                   Color(0xFFf8044c),
                  //                   Color(0xFFfb7773)
                  //                 ],
                  //                 begin: Alignment.bottomLeft,
                  //                 end: Alignment.topRight),
                  //             borderRadius: BorderRadius.circular(10.0.h())),
                  //         child: Text(
                  //           'Buy car',
                  //           style: style1.copyWith(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // if (widget.tokenModel != null &&
                  //     widget.tokenModel!.isSalesPerson())
                  //   Center(
                  //     child: InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: 55.0.h(),
                  //         width: 130.0.w(),
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             color: const Color(0xFF389df0),
                  //             borderRadius: BorderRadius.circular(10.0.h())),
                  //         child: Text(
                  //           'SET BID TIME',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium!
                  //               .copyWith(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: widget.vbim != null ? 100.0.h() : 50.0.h(),
        child: FloatingActionButton.extended(
          shape: const ContinuousRectangleBorder(
              side: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(67), right: Radius.circular(67))),
          backgroundColor: Colors.white,
          label: Container(
            width: 300.0.w(),
            alignment: Alignment.center,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.vbim != null)
                    Consumer(builder: (context, ref, child) {
                      ref.watch(refresh2Provider);
                      Duration diff =
                          widget.vbim!.closingTime.difference(DateTime.now());
                      ref.watch(refresh2Provider);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("₹ ${_amount.toString()}"),
                          SizedBox(
                            height: 5.0.h(),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Bidding ends in ",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14.0.h(),
                                )),
                            TextSpan(
                                text: formatDuration(diff),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14.0.h(),
                                ))
                          ])),
                        ],
                      );
                    }),
                  SizedBox(
                    height: 5.0.h(),
                  ),
                  InkWell(
                    onTap: () {
                      _showPlacingBidCar();
                    },
                    child: Container(
                      height: 45.0.h(),
                      width: 100.0.w(),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          boxShadow: boxShadow1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Place Bid',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {},
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: Colors.green,
      //     shape: RoundedRectangleBorder(),
      //     onPressed: () {
      //       _showPlacingBidCar();
      //     },
      //     label: Center(
      //       child: Container(
      //           width: double.maxFinite,
      //           alignment: Alignment.center,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "Place Bid",
      //                 style: TextStyle(color: Colors.white),
      //               ),
      //             ],
      //           )),
      //     )
      // )
    );
  }
}
