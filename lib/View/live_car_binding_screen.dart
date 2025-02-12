import 'dart:async';

import 'package:dealer_caryanam/Constant/resizing.dart';
import 'package:dealer_caryanam/Controller/controller.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/Model/vehicle_bidding_info_model.dart';
import 'package:dealer_caryanam/Model/vehicle_model.dart';
import 'package:dealer_caryanam/View/socket_service.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:dealer_caryanam/View/vehicle_details_screen.dart';
import 'package:dealer_caryanam/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Controller/shared_service.dart';
import 'get_start_screen.dart';

class LiveCarBindingScreen extends ConsumerStatefulWidget {
  final TokenModel token;
  const LiveCarBindingScreen({super.key, required this.token});

  @override
  ConsumerState<LiveCarBindingScreen> createState() =>
      _LiveCarBindingScreenState();
}

class _LiveCarBindingScreenState extends ConsumerState<LiveCarBindingScreen> {
  late final FutureProvider<List<VehicleBiddingInfoModel>> _liveBiddingProvider;
  late final Timer _refTimer;
  late final Timer _liveBidTimer;
  @override
  void initState() {
    super.initState();
    _liveBiddingProvider = FutureProvider<List<VehicleBiddingInfoModel>>((ref) {
      return ref
          .watch(apiProvider)
          .biddingLiveCar(token: widget.token.originalToken);
    });
    _refTimer = Timer.periodic(Duration(seconds: 1), (callback) {
      ref.read(refreshProvider.notifier).increment();
      ref.read(refresh2Provider.notifier).increment();
    });
    _liveBidTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      ref.refresh(_liveBiddingProvider);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refTimer.cancel();
    _liveBidTimer.cancel();
  }

  String _getCoverPhotoUrl({required List<dynamic>? imgInfoList}) {
    if (imgInfoList != null) {
      for (var action in imgInfoList) {
        if (action.documentType == 'coverImage' &&
            action.documentLink.isNotEmpty) {
          return action.documentLink;
        }
      }
    }
    return noCarImg;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (await SharedService.logOut(context: context)) {
                  showSnackBar(
                      color: Colors.green,
                      message: 'Logged out successfully',
                      context: context);

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginManager()),
                      (Route<dynamic> route) => false);
                }
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: ref.watch(_liveBiddingProvider).when(
          data: (List<VehicleBiddingInfoModel> biddingCarList) {
        return ListView.builder(
          itemCount: biddingCarList.length,
          itemBuilder: (context, index) {
            print(biddingCarList[index]);
            return FutureBuilder<VehicleModel?>(
              future: ref
                  .watch(apiProvider)
                  .getVehicleById(id: biddingCarList[index].beadingCarId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  VehicleModel vm = snapshot.data!;
                  Future.delayed(Duration.zero, () async {
                    vm.imgInfoList = await ref
                        .watch(apiProvider)
                        .vehicleImgModel2(carId: vm.beadingCarId);
                    ref.read(refreshProvider.notifier).increment();
                  });
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VehicleDetailsScreen(
                                vehicleModel: vm,
                                tokenModel: widget.token,
                                vbim: biddingCarList[index],
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0.w()),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10.0.h()),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 3)
                          ]),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0.h())),
                              child: Consumer(builder: (context, ref, child) {
                                ref.watch(refreshProvider);
                                return Image.network(
                                  _getCoverPhotoUrl(
                                      imgInfoList: vm.imgInfoList),
                                  width: 250.0.w(),
                                  height: 170.0.h(),
                                  fit: BoxFit.contain,
                                );
                              }),
                            ),
                          ),
                          Container(
                            height: 2.0.h(),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0.w(), vertical: 10.0.h()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${vm.brand} ${vm.model}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                // SizedBox(
                                //   height: 7.0.h(),
                                // ),
                                // Text(
                                //   '${vehicleList[index].kmDriven} km ${vehicleList[index].fuelType} ${vehicleList[index].transmission}',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .titleMedium!
                                //       .copyWith(
                                //           color:
                                //               const Color(0xFF1E1E1E),
                                //           fontSize: 14.0.h()),
                                // ),
                                SizedBox(
                                  height: 10.0.h(),
                                ),
                                SizedBox(
                                  height: 30.0.h(),
                                  width: 300.0.w(),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 7.0.w(),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context2, index2) {
                                      String data = '';
                                      IconData icon;
                                      if (index2 == 0) {
                                        icon = Icons.speed_outlined;
                                        data = '${vm.kmDriven} km';
                                      } else if (index2 == 1) {
                                        icon = Icons.local_gas_station_outlined;
                                        data = vm.fuelType;
                                      } else {
                                        icon = Icons.account_tree_rounded;
                                        data = vm.fuelType;
                                      }
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              icon,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 5.0.w(),
                                            ),
                                            Text(
                                              data,
                                              style: const TextStyle(
                                                color: Color(0xFF1E1E1E),
                                                fontSize: 15,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0.h(),
                                ),

                                // SizedBox(
                                //   height: 30.0.h(),
                                //   width: 300.0.w(),
                                //   child: ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: 3,
                                //     itemBuilder: (context2, index2) {
                                //       String data = '';
                                //       if (index2 == 0) {
                                //         data =
                                //             '${vehicleList[index].kmDriven} km';
                                //       } else if (index2 == 1) {
                                //         data = vehicleList[index]
                                //             .fuelType;
                                //       } else {
                                //         data = vehicleList[index]
                                //             .transmission;
                                //       }
                                //       return Align(
                                //         alignment: Alignment.center,
                                //         child: Container(
                                //           margin: EdgeInsets.only(
                                //               right: 15.0.w()),
                                //           padding:
                                //               const EdgeInsets.all(6),
                                //           decoration: BoxDecoration(
                                //               color: Colors.grey[350],
                                //               borderRadius:
                                //                   BorderRadius
                                //                       .circular(
                                //                           5.0.h())),
                                //           child: Text(
                                //             data,
                                //             style: const TextStyle(
                                //               color:
                                //                   Color(0xFF1E1E1E),
                                //               fontSize: 15,
                                //               fontFamily: 'Lato',
                                //               fontWeight:
                                //                   FontWeight.w500,
                                //               height: 0,
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 40.0.h(),
                                      decoration: BoxDecoration(
                                          boxShadow: boxShadow1,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          borderRadius:
                                              BorderRadius.circular(20.0.h())),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0.w()),
                                      child: Consumer(
                                          builder: (context, ref, child) {
                                        ref.watch(refreshProvider);
                                        return FutureBuilder(
                                          future: ref
                                              .watch(apiProvider)
                                              .bidCarById(
                                                  id: biddingCarList[index]
                                                      .bidCarId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data != null) {
                                              return Text(
                                                "Highest Bid ₹${snapshot.data!.amount}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              );
                                            } else {
                                              return Text(
                                                "Highest Bid ₹${biddingCarList[index].basePrice}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              );
                                            }
                                          },
                                        );
                                      }),
                                    )

                                    // Consumer(builder: (context, ref, child) {
                                    //     ref
                                    //         .watch(apiProvider)
                                    //         .bidCarById(
                                    //             id: biddingCarList[index]
                                    //                 .bidCarId).w;
                                    //     return Container(
                                    //       height: 40.0.h(),
                                    //       decoration: BoxDecoration(
                                    //           boxShadow: boxShadow1,
                                    //           color: Theme.of(context)
                                    //               .primaryColorLight,
                                    //           borderRadius:
                                    //               BorderRadius.circular(
                                    //                   20.0.h())),
                                    //       alignment: Alignment.center,
                                    //       padding: EdgeInsets.symmetric(
                                    //           horizontal: 10.0.w()),
                                    //       child: Text(
                                    //         "Highest Bid ₹",
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       ),
                                    //     );
                                    //   // FutureProvider<List?>
                                    //   //     vehiclePriceProvider =
                                    //   //     FutureProvider<List?>((ref) {
                                    //   //   return ref
                                    //   //       .watch(apiProvider)
                                    //   //       .bidCarById(
                                    //   //           id: biddingCarList[index]
                                    //   //               .bidCarId);
                                    //   // });
                                    //
                                    //   // _timerList.add(Timer.periodic(
                                    //   //     Duration(seconds: 1), (time) {
                                    //   //   DateTime ct = DateTime.now();
                                    //   //   if (biddingCarList[index]
                                    //   //           .createdAt
                                    //   //           .isBefore(ct) &&
                                    //   //       biddingCarList[index]
                                    //   //           .closingTime
                                    //   //           .isAfter(ct)) {
                                    //   //     ref.invalidate(vehiclePriceProvider);
                                    //   //   } else {
                                    //   //     time.cancel();
                                    //   //   }
                                    //
                                    //   // }));
                                    //   // return ref
                                    //   //     .watch(vehiclePriceProvider)
                                    //   //     .when(data: (data) {
                                    //   //   return Container(
                                    //   //     height: 40.0.h(),
                                    //   //     decoration: BoxDecoration(
                                    //   //         boxShadow: boxShadow1,
                                    //   //         color: Theme.of(context)
                                    //   //             .primaryColorLight,
                                    //   //         borderRadius:
                                    //   //             BorderRadius.circular(
                                    //   //                 20.0.h())),
                                    //   //     alignment: Alignment.center,
                                    //   //     padding: EdgeInsets.symmetric(
                                    //   //         horizontal: 10.0.w()),
                                    //   //     child: Text(
                                    //   //       "Highest Bid ₹",
                                    //   //       style:
                                    //   //           TextStyle(color: Colors.white),
                                    //   //     ),
                                    //   //   );
                                    //   // }, error: (error, st) {
                                    //   //   return Center(
                                    //   //     child: Text(error.toString()),
                                    //   //   );
                                    //   // }, loading: () {
                                    //   //   return Center(
                                    //   //     child: CircularProgressIndicator(),
                                    //   //   );
                                    //   // }
                                    //   //
                                    //   // );
                                    // }),
                                    ,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Timer",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Consumer(
                                            builder: (context, ref, child) {
                                          Duration diff = biddingCarList[index]
                                              .closingTime
                                              .difference(DateTime.now());
                                          ref.watch(refresh2Provider);

                                          return Text(
                                            formatDuration(diff),
                                            style: TextStyle(
                                                color: diff.inSeconds > 120
                                                    ? Colors.green
                                                    : Colors.red),
                                          );
                                        })
                                      ],
                                    ),
                                  ],
                                ),
                                // Text(
                                //   '₹ ${vm.price}',
                                //   style: const TextStyle(
                                //     color: Color(0xFF1E1E1E),
                                //     fontSize: 19,
                                //     fontFamily: 'Lato',
                                //     fontWeight: FontWeight.w500,
                                //     height: 0,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.0.h(),
                                ),

                                Text(
                                  vm.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 14.0.h()),
                                ),
                                SizedBox(
                                  height: 7.0.h(),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5.0.w(),
                                    ),
                                    Text(
                                      '${vm.area}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              // color: Colors.green,
                                              ),
                                    ),
                                  ],
                                )
                                // Text(
                                //   'Free Test Drive Today at ${vehicleList[index].area}',
                                //   style: const TextStyle(
                                //     color: Color(0xFF1E1E1E),
                                //     fontSize: 14,
                                //     fontFamily: 'Lato',
                                //     fontWeight: FontWeight.w600,
                                //     height: 0,
                                //   ),
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            );
            // VehicleModel? vehicleModel=await ref.watch(apiProvider).getVehicleById(id: );
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0.w()),
              decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10.0.h()),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, spreadRadius: 3)
                  ]),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0.h())),
                    child: Image.network(
                      noCarImg,
                      width: 250.0.w(),
                      height: 170.0.h(),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    height: 2.0.h(),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.0.w(), vertical: 10.0.h()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'brand model',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(
                        //   height: 7.0.h(),
                        // ),
                        // Text(
                        //   '${vehicleList[index].kmDriven} km ${vehicleList[index].fuelType} ${vehicleList[index].transmission}',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .titleMedium!
                        //       .copyWith(
                        //           color:
                        //               const Color(0xFF1E1E1E),
                        //           fontSize: 14.0.h()),
                        // ),
                        SizedBox(
                          height: 10.0.h(),
                        ),
                        SizedBox(
                          height: 30.0.h(),
                          width: 300.0.w(),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 7.0.w(),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context2, index2) {
                              String data = '';
                              IconData icon;
                              if (index2 == 0) {
                                icon = Icons.speed_outlined;
                                data = '${"Km"} km';
                              } else if (index2 == 1) {
                                icon = Icons.local_gas_station_outlined;
                                data = "Fuel type";
                              } else {
                                icon = Icons.account_tree_rounded;
                                data = "tranmission";
                              }
                              return Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5.0.w(),
                                    ),
                                    Text(
                                      data,
                                      style: const TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 15,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h(),
                        ),

                        // SizedBox(
                        //   height: 30.0.h(),
                        //   width: 300.0.w(),
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 3,
                        //     itemBuilder: (context2, index2) {
                        //       String data = '';
                        //       if (index2 == 0) {
                        //         data =
                        //             '${vehicleList[index].kmDriven} km';
                        //       } else if (index2 == 1) {
                        //         data = vehicleList[index]
                        //             .fuelType;
                        //       } else {
                        //         data = vehicleList[index]
                        //             .transmission;
                        //       }
                        //       return Align(
                        //         alignment: Alignment.center,
                        //         child: Container(
                        //           margin: EdgeInsets.only(
                        //               right: 15.0.w()),
                        //           padding:
                        //               const EdgeInsets.all(6),
                        //           decoration: BoxDecoration(
                        //               color: Colors.grey[350],
                        //               borderRadius:
                        //                   BorderRadius
                        //                       .circular(
                        //                           5.0.h())),
                        //           child: Text(
                        //             data,
                        //             style: const TextStyle(
                        //               color:
                        //                   Color(0xFF1E1E1E),
                        //               fontSize: 15,
                        //               fontFamily: 'Lato',
                        //               fontWeight:
                        //                   FontWeight.w500,
                        //               height: 0,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        Text(
                          '₹ ${"Price"}',
                          style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 19,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h(),
                        ),

                        Text(
                          '${"Date "}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: const Color(0xFF1E1E1E),
                                  fontSize: 14.0.h()),
                        ),
                        SizedBox(
                          height: 7.0.h(),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5.0.w(),
                            ),
                            Text(
                              '${"Area "}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      // color: Colors.green,
                                      ),
                            ),
                          ],
                        )
                        // Text(
                        //   'Free Test Drive Today at ${vehicleList[index].area}',
                        //   style: const TextStyle(
                        //     color: Color(0xFF1E1E1E),
                        //     fontSize: 14,
                        //     fontFamily: 'Lato',
                        //     fontWeight: FontWeight.w600,
                        //     height: 0,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }, error: (error, st) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
