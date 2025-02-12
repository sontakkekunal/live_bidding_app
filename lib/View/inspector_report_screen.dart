import 'package:dealer_caryanam/View/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Constant/resizing.dart';
import '../Controller/controller.dart';
import '../Controller/local_data_controller.dart';
import '../Model/car_beading_model.dart';
import '../Model/car_verify_model.dart';
import '../Model/imp_doc_model.dart';

class InspectorReportScreen extends ConsumerStatefulWidget {
  final int beadingId;
  const InspectorReportScreen({super.key, required this.beadingId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _InspectorReportScreenState();
  }
}

class _InspectorReportScreenState extends ConsumerState<InspectorReportScreen> {
  late final int beadingId;
  final ScrollController _controller = ScrollController();
  ImpDocModel impDocModel = ImpDocModel(
      inspectionReportId: -1,
      userId: -1,
      beadingCarId: -1,
      registrationDate: '',
      rto: '',
      fitnessUpto: '',
      cnglpgfitmentInRC: '',
      nocstatus: '',
      rcavailability: '',
      mismatchInRC: '',
      rtonocissued: '',
      insuranceType: '',
      noClaimBonus: '',
      underHypothecation: '',
      loanStatus: '',
      roadTaxPaid: '',
      partipeshiRequest: '',
      duplicateKey: '',
      chassisNumberEmbossing: '',
      manufacturingDate: '');

  @override
  void deactivate() {
    super.deactivate();
    ref.refresh(getListOfPageProvider);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    beadingId = widget.beadingId;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      getPanelDetail();
    });
  }

  Future<void> getPanelDetail() async {
    showCircularProcess(context: context);
    for (int z = 0; z < ref.watch(getListOfPageProvider).length - 1; z++) {
      int activeIndex = z;
      List<InspectorCarImgInfo>? exteriorList = await ref
          .watch(apiProvider)
          .getCarVerficationPanel(
              beadingId: beadingId, activeIndex: activeIndex);
      if (exteriorList != null) {
        for (int i = 0;
            i < ref.watch(getListOfPageProvider)[activeIndex].length;
            i++) {
          for (int j = 0;
              j <
                  ref
                      .watch(getListOfPageProvider)[activeIndex][i]
                      .carPartList
                      .length;
              j++) {
            try {
              InspectorCarImgInfo icii = exteriorList.lastWhere((obj) {
                return obj.subtype ==
                    ref
                        .watch(getListOfPageProvider)[activeIndex][i]
                        .carPartList[j]
                        .matchKey;
              });
              if (ref
                  .watch(getListOfPageProvider)[activeIndex][i]
                  .carPartList[j]
                  .options
                  .contains(icii.comment)) {
                ref
                    .watch(getListOfPageProvider)[activeIndex][i]
                    .carPartList[j]
                    .docLink = icii.documentLink;
                ref
                    .watch(getListOfPageProvider)[activeIndex][i]
                    .carPartList[j]
                    .docId = icii.documentId;
                ref
                    .watch(getListOfPageProvider)[activeIndex][i]
                    .carPartList[j]
                    .value = icii.comment;
              } else {
                print(
                    "${ref.watch(getListOfPageProvider)[activeIndex][i].carPartList[j].name} = ${icii.comment}");
              }
            } catch (e) {
              continue;
            }
          }
        }
      }
    }
    ImpDocModel? idm = await ref.watch(apiProvider).getImpDoc(id: beadingId);
    if (idm != null) {
      impDocModel = idm;
    }
    ref.read(refreshProvider.notifier).increment();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    List<List<CarVerifyModel>> reportList = ref.watch(getListOfPageProvider);
    List<String> positionList = [
      'Document',
      'Exterior',
      'Interior',
      'Engine',
      'AC',
      'Electrical',
      'Steering'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100.0.h(),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Inspector Report',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0.h(),
            ),
            SizedBox(
              height: 35.0.h(),
              width: double.maxFinite,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: positionList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 1) {
                        _controller.animateTo(600.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 2) {
                        _controller.animateTo(2900.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 3) {
                        _controller.animateTo(3200.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 4) {
                        _controller.animateTo(3600.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 5) {
                        _controller.animateTo(4000.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      } else if (index == 6) {
                        _controller.animateTo(4200.0.h(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      }
                    },
                    child: Container(
                      height: 35.0.h(),
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w()),
                      margin: EdgeInsets.only(right: 20.0.w()),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(15.0.h())),
                      child: Text(
                        positionList[index],
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0.h(),
              ),
              Text(
                'Important Document',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0.h(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0.w(), vertical: 10.0.h()),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.h()),
                    border: Border.all(color: Colors.black, width: 1.0.h())),
                alignment: Alignment.centerLeft,
                child: Consumer(builder: (context, ref, child) {
                  ref.watch(refreshProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: impDocModel.getImpDocSq().map((element) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.h()),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "${element.question} :",
                              style: Theme.of(context).textTheme.titleMedium),
                          TextSpan(
                            text: "  ${element.answer}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ])),
                      );
                    }).toList(),
                  );
                }),
              ),
              SizedBox(
                height: 8.0.h(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ref
                    .watch(getListOfPageProvider)
                    .sublist(0, ref.watch(getListOfPageProvider).length - 1)
                    .map((element1) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0.h()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (reportList.first == element1)
                          Text(
                            'Exterior',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        if (reportList.first != element1)
                          Text(
                            element1.first.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        if (reportList.first == element1)
                          SizedBox(
                            height: 8.0.h(),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: element1.map((element2) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0.h()),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (reportList.first == element1)
                                    Text(
                                      element2.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  SizedBox(
                                    height: 14.0.h(),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w(),
                                        vertical: 10.0.h()),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0.h()),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1.0.h())),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          element2.carPartList.map((element3) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0.h()),
                                          child: Consumer(
                                              builder: (context, ref, child) {
                                            ref.watch(refreshProvider);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "${element3.name} :  ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium),
                                                  TextSpan(
                                                    text: element3.value ?? "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )
                                                ])),
                                                if (element3.docLink != null)
                                                  SizedBox(
                                                    height: 7.0.h(),
                                                  ),
                                                if (element3.docLink != null)
                                                  Image.network(
                                                    element3.docLink!,
                                                    height: 80.0.h(),
                                                    width: 110.0.w(),
                                                  )
                                              ],
                                            );
                                          }),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
