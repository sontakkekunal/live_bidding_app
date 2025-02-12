import 'package:dealer_caryanam/Constant/resizing.dart';
import 'package:dealer_caryanam/Model/bids_with_vehicle_model.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:dealer_caryanam/View/vehicle_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

import '../Controller/controller.dart';
import '../Model/vehicle_winner_model.dart';

class WinnerVehicleScreen extends StatefulWidget {
  final TokenModel tokenModel;
  const WinnerVehicleScreen({super.key, required this.tokenModel});

  @override
  State<WinnerVehicleScreen> createState() => _WinnerVehicleScreenState();
}

class _WinnerVehicleScreenState extends State<WinnerVehicleScreen> {
  late FutureProvider<List<BidsWithVehicleModel>> _finalBidsProvider;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _finalBidsProvider = FutureProvider<List<BidsWithVehicleModel>>((ref) {
      return ref.watch(apiProvider).finalBidsWithVehicleList(
          dealerId: widget.tokenModel.userId, pageNo: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w(), vertical: 20.0.h()),
        child: Consumer(builder: (context, ref, child) {
          return ref.watch(_finalBidsProvider).when(
              data: (bidsWithVehicleModelList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0.h(),
                ),
                Text(
                  'Winning Bidding Car List (${bidsWithVehicleModelList.length})',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 65.0.h(),
                  width: 240.0.w(),
                  child: Text(
                    'See Information About All Bidding Cars',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                // ??
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                          //height: 25.0.h(),
                          );
                    },
                    // primary: false,
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: bidsWithVehicleModelList.length,
                    itemBuilder: (context, index) {
                      final BidsWithVehicleModel bidsModel =
                          bidsWithVehicleModelList[index];
                      return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //borderRadius: BorderRadius.circular(20.0.h()),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 4.0.h(),
                                    blurRadius: 6.0.h())
                              ]),
                          alignment: Alignment.center,
                          child: Column(children: [
                            Container(
                              height: 50.0.h(),
                              padding: EdgeInsets.only(
                                  left: 50.0.w(), right: 20.0.w()),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.vertical(
                                  //     top: Radius.circular(20.0.h())),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 4.0.h(),
                                        blurRadius: 6.0.h())
                                  ],
                                  color: Theme.of(context).primaryColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Sr No: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                    TextSpan(
                                        text: "${index + 1}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white))
                                  ])),
                                  InkWell(
                                    onTap: () async {
                                      showCircularProcess(context: context);
                                      bidsWithVehicleModelList[index]
                                              .vehicleModel
                                              .imgInfoList =
                                          await ref
                                              .watch(apiProvider)
                                              .vehicleImgModel2(
                                                  carId:
                                                      bidsWithVehicleModelList[
                                                              index]
                                                          .vehicleModel
                                                          .beadingCarId);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return VehicleDetailsScreen(
                                            tokenModel: widget.tokenModel,
                                            vehicleModel:
                                                bidsWithVehicleModelList[index]
                                                    .vehicleModel);
                                      }));
                                    },
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15.0.w()),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.0.h(),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0.h()),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade600))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 20.0.w()),
                                          width: 120.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text("Code : ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                        ),
                                        Container(
                                          width: 150.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              bidsModel.vehicleModel
                                                  .uniqueBeadingCarId,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h(),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0.h()),

                                    //padding: EdgeInsets.only(left: 50.0.w()),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade600))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120.0.w(),
                                          padding:
                                              EdgeInsets.only(left: 20.0.w()),
                                          alignment: Alignment.centerLeft,
                                          child: Text("Brand : ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                        ),
                                        Container(
                                          width: 150.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              bidsModel.vehicleModel.brand
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h(),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0.h()),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade600))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 20.0.w()),
                                          width: 120.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text("Model : ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                        ),
                                        Container(
                                          width: 150.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              bidsModel.vehicleModel.model
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h(),
                                  ),
                                  Container(
                                    height: 40.0.h(),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0.h()),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade600))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120.0.w(),
                                          padding:
                                              EdgeInsets.only(left: 20.0.w()),
                                          alignment: Alignment.centerLeft,
                                          child: Text("Price: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                        ),
                                        Container(
                                          width: 150.0.w(),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              bidsModel.finalBidsModel.price
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.0.h()),
                                ],
                              ),
                            )
                          ]));
                    },
                  ),
                ),
                // ??
                // PaginatedDataTable(
                //   showEmptyRows: false,
                //   columnSpacing: 20.0.h(),
                //   onPageChanged: (int index) {},
                //
                //   //dataRowMinHeight: 30,
                //   //dataRowMaxHeight: 110.0.h(),
                //   rowsPerPage: 10,
                //   source: WinningInfoTable(
                //       dataList: dataList,
                //       context: context,
                //       ref: ref,
                //       token: widget.tokenModel,
                //       callBackFun: () {}),
                //   columns: [
                //     DataColumn(
                //         label: Text(
                //       'Sr. No',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.titleMedium,
                //     )),
                //     DataColumn(
                //         label: Text(
                //       'Code',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.titleMedium,
                //     )),
                //     DataColumn(
                //         label: Text(
                //       'Brand',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.titleMedium,
                //     )),
                //     DataColumn(
                //         label: Text(
                //       'Model',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.titleMedium,
                //     )),
                //     DataColumn(
                //         label: Text(
                //       'Top Bidding Amount',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.titleMedium,
                //     )),
                //     DataColumn(
                //         label: Center(
                //       child: Text(
                //         'Action',
                //         textAlign: TextAlign.center,
                //         style: Theme.of(context).textTheme.titleMedium,
                //       ),
                //     ))
                //   ],
                // ),

                NumberPaginator(
                  initialPage: _currentPage - 1,
                  numberPages: bidsWithVehicleModelList.length == 50
                      ? _currentPage + 1
                      : _currentPage,
                  showPrevButton: false,
                  showNextButton: false,
                  config: const NumberPaginatorUIConfig(
                      mode: ContentDisplayMode.numbers),
                  onPageChange: (int index) {
                    if (index != _currentPage - 1) {
                      _currentPage = index + 1;
                      _finalBidsProvider =
                          FutureProvider<List<BidsWithVehicleModel>>((ref) {
                        return ref.watch(apiProvider).finalBidsWithVehicleList(
                            dealerId: widget.tokenModel.userId, pageNo: index);
                      });
                      ref.invalidate(_finalBidsProvider);
                      setState(() {});
                    }
                  },
                )
              ],
            );
          }, error: (error, st) {
            return Center(
              child: Text(
                "You Didn't Win Any Car",
                style: TextStyle(color: Colors.red, fontSize: 18.0.h()),
              ),
            );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
        }),
      ),
    );
  }
}

class WinningInfoTable extends DataTableSource {
  final List<BidsWithVehicleModel> dataList;
  final WidgetRef ref;
  final TokenModel token;
  final Function callBackFun;

  BuildContext context;
  WinningInfoTable(
      {required this.dataList,
      required this.context,
      required this.ref,
      required this.token,
      required this.callBackFun});
  @override
  DataRow? getRow(int index) {
    final style = Theme.of(context).textTheme.titleMedium;
    return DataRow(cells: [
      DataCell(Text("${index + 1}", style: style)),
      DataCell(Text(
        dataList[index].vehicleModel.uniqueBeadingCarId,
        textAlign: TextAlign.justify,
        style: style,
      )),
      DataCell(Text(
        dataList[index].vehicleModel.brand,
        textAlign: TextAlign.justify,
        style: style,
      )),
      DataCell(Text(
        dataList[index].vehicleModel.model,
        textAlign: TextAlign.justify,
        style: style,
      )),
      DataCell(Center(
        child: Text(
          "${dataList[index].finalBidsModel.price}",
          textAlign: TextAlign.justify,
          style: style,
        ),
      )),
      DataCell(Center(
        child: InkWell(
          onTap: () async {
            showCircularProcess(context: context);
            dataList[index].vehicleModel.imgInfoList = await ref
                .watch(apiProvider)
                .vehicleImg(carId: dataList[index].vehicleModel.beadingCarId);
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return VehicleDetailsScreen(
                  tokenModel: token,
                  vehicleModel: dataList[index].vehicleModel);
            }));
          },
          child: const Icon(
            Icons.info_outline,
            color: Colors.blue,
          ),
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => 0;
}
