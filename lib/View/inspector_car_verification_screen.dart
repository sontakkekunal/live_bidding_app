import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dealer_caryanam/Model/textformfeild_model.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Constant/resizing.dart';
import '../Controller/controller.dart';
import '../Controller/local_data_controller.dart';
import '../Model/car_beading_model.dart';
import '../Model/car_verify_model.dart';
import '../Model/imp_doc_model.dart';
import '../Model/token_model.dart';
import 'camera_capture_screen.dart';

class InspectorCarVerificationScreen extends ConsumerStatefulWidget {
  final int beadingId;
  final TokenModel token;
  const InspectorCarVerificationScreen(
      {super.key, required this.beadingId, required this.token});

  @override
  ConsumerState createState() {
    return _InspectorCarVerificationScreenState();
  }
}

class _InspectorCarVerificationScreenState
    extends ConsumerState<InspectorCarVerificationScreen> {
  int _activeIndex = 0;
  ImpDocModel? idm;
  late final int beadingId;
  final DateFormat df = DateFormat("MM/dd/yyyy");
  static final List<String> list1 = [
    "Ok",
    "Repainted",
    "Dented",
    "Scratched",
    "Rusted",
    "Repaired",
    "Damaged",
    "Faded"
  ];
  static final List<String> list2 = ["Ok", "Replaced", "Damaged"];
  static final List<String> list3 = [
    "Ok",
    "Scratched",
    "Repaired",
    "Damaged",
  ];
  static final List<String> list4 = [
    "Ok",
    "Scratched",
    "Repaired",
    "Damaged",
    "Not Working"
  ];
  static final List<String> list5 = [
    "Ok",
    "NotWorking",
    "Damaged",
    "Missing",
    "Mirror Broken/Cracked"
  ];
  static final List<String> list7 = [
    "Ok",
    "Repainted",
    "Dented",
    "Scratched",
    "Rusted",
    "Repaired",
    "Damaged",
  ];
  static final List<String> list8 = [
    "Repainted",
    "Dented",
    "Scratched",
    "Rusted",
    "Repaired",
    "Damaged",
    "Broken",
    "OneSide"
  ];
  static final List<String> list9 = [
    "Ok",
    "Repainted",
    "Dented",
    "Scratched",
    "Rusted",
    "Repaired",
    "Damaged",
    "Faded",
    "Replaced"
  ];
  static final List<String> list10 = [
    "Ok",
    "Repainted",
    "Dented",
    "Scratched",
    "Rusted",
    "Repaired",
    "Damaged",
    "Faded",
    "Sealent Broken"
  ];
  @override
  void deactivate() {
    super.deactivate();
    ref.refresh(getListOfPageProvider);
  }

  static final List<String> list11 = ["Ok", "Torn", "Worn Out"];
  static final List<String> list12 = ["Not Working", "Ok", "Damaged"];
  static final List<String> list6 = ["ok-69-85%", "Not Ok 22-38%", "Damaged"];
  // final List<List<CarVerifyModel>> ref.watch(getListOfPageProvider) = [
  //   [
  //     CarVerifyModel(
  //         name: 'Exterior Panel',
  //         docMatch: 'Exterior',
  //         carPartList: [
  //           CarPartModel(
  //               name: 'Bonnet / Hood', matchKey: 'BonnetHood', options: list1),
  //           CarPartModel(
  //               name: 'Right Door Front',
  //               matchKey: 'RightDoorFront',
  //               options: list1),
  //           CarPartModel(
  //               name: 'Left Door Front',
  //               matchKey: 'LeftDoorFront',
  //               options: list1),
  //           CarPartModel(
  //               name: 'Right Fender', matchKey: 'RightFender', options: list1),
  //           CarPartModel(
  //               name: 'Left Quarter Panel',
  //               matchKey: 'LeftQuarterPanel',
  //               options: list1),
  //           CarPartModel(
  //               name: 'Right Quarter Panel',
  //               matchKey: 'RightQuarterPanel',
  //               options: list1),
  //           CarPartModel(name: 'Roof', matchKey: 'Roof', options: list1),
  //           CarPartModel(
  //               name: 'Dicky Door', matchKey: 'DickyDoor', options: list1),
  //           CarPartModel(
  //               name: 'Left Door Rear',
  //               matchKey: 'LeftDoorRear',
  //               options: list1),
  //           CarPartModel(
  //               name: 'Right Door Rear',
  //               matchKey: 'RightDoorRear',
  //               options: list1),
  //           CarPartModel(
  //               name: 'Left Fender', matchKey: 'LeftFender', options: list1),
  //         ]),
  //     CarVerifyModel(
  //         name: 'Windshield And Lights',
  //         docMatch: 'Exterior',
  //         carPartList: [
  //           CarPartModel(
  //               name: 'Windshield', matchKey: 'Windshield', options: list2),
  //           CarPartModel(
  //               name: 'Front Windshield',
  //               matchKey: 'FrontWindshield',
  //               options: list2),
  //           CarPartModel(
  //               name: 'Rear Windshield',
  //               matchKey: 'RearWindshield',
  //               options: [...list2, 'Dented']),
  //           CarPartModel(name: 'Light', matchKey: 'Light', options: list3),
  //           CarPartModel(
  //               name: 'Front Bumper', matchKey: 'FrontBumper', options: list1),
  //           CarPartModel(
  //               name: 'Rear Bumper', matchKey: 'RearBumper', options: list1),
  //           CarPartModel(
  //               name: 'LHS Headlight',
  //               matchKey: 'LHSHeadlight',
  //               options: list4),
  //           CarPartModel(
  //               name: 'RHS Headlight',
  //               matchKey: 'RHSHeadlight',
  //               options: list4),
  //           CarPartModel(
  //               name: 'LHS Taillight',
  //               matchKey: 'LHSTaillight',
  //               options: list4),
  //           CarPartModel(
  //               name: 'RHS Taillight',
  //               matchKey: 'RHSTaillight',
  //               options: list4),
  //           CarPartModel(name: 'LHS ORVM', matchKey: 'LHSORVM', options: list5),
  //           CarPartModel(name: 'RHS ORVM', matchKey: 'RHSORVM', options: list5),
  //         ]),
  //     CarVerifyModel(name: 'Tyres', docMatch: 'Exterior', carPartList: [
  //       CarPartModel(
  //           name: 'LHS Front Tyre', matchKey: 'LHSFrontTyre', options: list6),
  //       CarPartModel(
  //           name: 'RHS Front Tyre', matchKey: 'RHSFrontTyre', options: list6),
  //       CarPartModel(
  //           name: 'LHS Rear Tyre', matchKey: 'LHSRearTyre', options: list6),
  //       CarPartModel(
  //           name: 'RHS Rear Tyre', matchKey: 'RHSRearTyre', options: list6),
  //       CarPartModel(name: 'Spare Tyre', matchKey: 'SpareTyre', options: list6),
  //     ]),
  //     CarVerifyModel(
  //         name: 'Other Components',
  //         docMatch: 'Exterior',
  //         carPartList: [
  //           CarPartModel(
  //               name: 'Head Light Support',
  //               matchKey: 'HeadLightSupport',
  //               options: list7),
  //           CarPartModel(
  //               name: 'Radiator Support',
  //               matchKey: 'RadiatorSupport',
  //               options: list7),
  //           CarPartModel(
  //               name: 'Alloy Wheel', matchKey: 'AlloyWheel', options: list7),
  //           CarPartModel(
  //               name: 'CarPoolingon',
  //               matchKey: 'CarPoolingon',
  //               options: ["On Side", "NoPooling"]),
  //           CarPartModel(
  //               name: 'LHS Running Border',
  //               matchKey: 'LHSRunningBorder',
  //               options: list8),
  //           CarPartModel(
  //               name: 'RHS Running Border',
  //               matchKey: 'RHSRunningBorder',
  //               options: list8),
  //           CarPartModel(
  //               name: 'Upper Cross Member',
  //               matchKey: 'UpperCrossMember',
  //               options: list8),
  //         ]),
  //     CarVerifyModel(name: 'Structure', docMatch: 'Exterior', carPartList: [
  //       CarPartModel(name: 'Cowl Top', matchKey: 'CowlTop', options: list1),
  //       CarPartModel(name: 'Boot Floor', matchKey: 'BootFloor', options: list1),
  //       CarPartModel(
  //           name: 'Right Apron LEG', matchKey: 'RightApronLEG', options: list9),
  //       CarPartModel(
  //           name: 'Left Apron LEG', matchKey: 'LeftApronLEG', options: list9),
  //       CarPartModel(
  //           name: 'Right Apron', matchKey: 'RightApron', options: list9),
  //       CarPartModel(name: 'Left Apron', matchKey: 'LeftApron', options: list9),
  //       CarPartModel(
  //           name: 'Left Pillar', matchKey: 'LeftPillar', options: list10),
  //       CarPartModel(
  //           name: 'Left Pillar A', matchKey: 'LeftPillarA', options: list10),
  //       CarPartModel(
  //           name: 'Left Pillar B', matchKey: 'LeftPillarB', options: list10),
  //       CarPartModel(
  //           name: 'Left Pillar C', matchKey: 'LeftPillarC', options: list10),
  //       CarPartModel(
  //           name: 'Right Pillar', matchKey: 'RightPillar', options: list10),
  //       CarPartModel(
  //           name: 'Right Pillar A', matchKey: 'RightPillarA', options: list10),
  //       CarPartModel(
  //           name: 'Right Pillar B', matchKey: 'RightPillarB', options: list10),
  //       CarPartModel(
  //           name: 'Right Pillar C', matchKey: 'RightPillarC', options: list10),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(name: 'Interior', docMatch: 'Interior', carPartList: [
  //       CarPartModel(
  //           name: 'Leather Seat', matchKey: 'LeatherSeat', options: list11),
  //       CarPartModel(
  //           name: 'Odometer',
  //           matchKey: 'Odometer',
  //           options: ['Ok', 'Tempered', 'Not Tempered']),
  //       CarPartModel(
  //           name: 'Cabin Floor',
  //           matchKey: 'CabinFloor',
  //           options: ['Ok', 'Dented', 'Rusted']),
  //       CarPartModel(name: 'Dashboard', matchKey: 'Dashboard', options: list7),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(name: 'Engine', docMatch: 'Engine', carPartList: [
  //       CarPartModel(name: 'Engine', matchKey: 'Engine', options: [
  //         "Ok",
  //         "Misfiring",
  //         "Long crack due to weak Compression",
  //         "Permissible blow- by on idle",
  //         "Fuel leaking from injector",
  //         "MIL light glowing",
  //         "RPM Fluctuating",
  //         "Over Heating"
  //       ]),
  //       CarPartModel(
  //           name: 'Engine Mounting',
  //           matchKey: 'EngineMounting',
  //           options: ["Ok", "Loose", "Tight", "Excess Vibration"]),
  //       CarPartModel(name: 'Engine Sound', matchKey: 'EngineSound', options: [
  //         "Ok",
  //         "Minor sound",
  //         "No engine sound",
  //         "Critical sound",
  //         "No Blow-by"
  //       ]),
  //       CarPartModel(name: 'Exhaust Smoke', matchKey: 'Exhaustsmoke', options: [
  //         "Ok",
  //         "Black",
  //         "Blue",
  //         "Silencer assembly Damaged and Create Noise"
  //       ]),
  //       CarPartModel(
  //           name: 'Gearbox',
  //           matchKey: 'Gearbox',
  //           options: ["Ok", "Abnormal Noise", "Oil leakage", "Shifting-Hard"]),
  //       CarPartModel(
  //           name: 'Engine Oil',
  //           matchKey: 'Engineoil',
  //           options: ["Low Level", "Leakage", "Deteriorated"]),
  //       CarPartModel(name: 'Battery', matchKey: 'Battery', options: [
  //         "Ok",
  //         "Weak",
  //         "jump",
  //         'start',
  //         'Dead',
  //         'Acid',
  //         'leakage'
  //       ]),
  //       CarPartModel(
  //           name: 'Coolant',
  //           matchKey: 'Coolant',
  //           options: ['Low Level', 'Leakage', 'Deteriorated']),
  //       CarPartModel(
  //           name: 'Clutch',
  //           matchKey: 'Clutch',
  //           options: ['Ok', 'Slipping', 'Hard', 'Spongy']),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(name: 'AC', docMatch: 'AC', carPartList: [
  //       CarPartModel(
  //           name: 'AC Cooling',
  //           matchKey: 'ACCooling',
  //           options: ['Ok', 'Ineffective', 'Not Working', 'Misfiring']),
  //       CarPartModel(
  //           name: 'Heater',
  //           matchKey: 'Heater',
  //           options: ['Ok', 'Ineffective', 'Not Working']),
  //       CarPartModel(
  //           name: 'Climate Control AC',
  //           matchKey: 'ClimateControlAC',
  //           options: ['Ok', 'Ineffective', 'Not Working', 'Misfiring']),
  //       CarPartModel(
  //           name: 'Ac Vent', matchKey: 'AcVent', options: ['Ok', 'Damaged']),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(name: 'Electricals', docMatch: 'Eletrical', carPartList: [
  //       CarPartModel(
  //           name: 'Four Power Windows',
  //           matchKey: 'FourPowerWindows',
  //           options: list12),
  //       CarPartModel(
  //           name: 'Air Bag Features',
  //           matchKey: 'AirBagFeatures',
  //           options: list12),
  //       CarPartModel(
  //           name: 'Music System', matchKey: 'MusicSystem', options: list12),
  //       CarPartModel(
  //           name: 'Sunroof',
  //           matchKey: 'Sunroof',
  //           options: ['Not Working', 'NA', 'Damaged']),
  //       CarPartModel(
  //           name: 'ABS',
  //           matchKey: 'ABS',
  //           options: ['Ok', 'Not Working', 'NA', 'Damaged']),
  //       CarPartModel(
  //           name: 'Interior Parking Sensor',
  //           matchKey: 'InteriorParkingSensor',
  //           options: list12),
  //       CarPartModel(
  //           name: 'Electrical Wiring',
  //           matchKey: 'Electricalwiring',
  //           options: list12),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(name: 'Steering', docMatch: 'Steering', carPartList: [
  //       CarPartModel(
  //           name: 'Steering',
  //           matchKey: 'Steering',
  //           options: ['Ok', 'Abnormal Noise', 'Hard']),
  //       CarPartModel(name: 'Brake', matchKey: 'Brake', options: [
  //         'Ok',
  //         'Noisy',
  //         'Hard Noise',
  //         'Not Working',
  //       ]),
  //       CarPartModel(
  //           name: 'Suspension',
  //           matchKey: 'Suspension',
  //           options: ['Ok', 'Abnormal Noise', 'Weak', 'Not Working']),
  //     ]),
  //   ],
  //   [
  //     CarVerifyModel(
  //         name: 'Important documents',
  //         docMatch: 'None',
  //         carPartList: [
  //           CarPartModel(
  //               name: 'RC Availability', matchKey: '', options: ['Yes', 'No']),
  //           CarPartModel(
  //               name: 'Mismatch in RC',
  //               matchKey: '',
  //               options: ['No mismatch', 'mismatch']),
  //           CarPartModel(
  //               name: 'RTO NOC Issued', matchKey: '', options: ['Yes', 'No']),
  //           CarPartModel(name: 'Insurance Type', matchKey: '', options: [
  //             'Zero Depreciation',
  //             'Comprehensive',
  //             '3rd Party',
  //             'Insurance Expired'
  //           ]),
  //           CarPartModel(
  //               name: 'No Claim Bonus', matchKey: '', options: ['Yes', 'No']),
  //           CarPartModel(name: 'Loan Status', matchKey: '', options: [
  //             'Paid/Closed',
  //             'Unpaid/Pending',
  //           ]),
  //           CarPartModel(
  //               name: 'Under Hypothecation',
  //               matchKey: '',
  //               options: ['Yes', 'No']),
  //           CarPartModel(name: 'Road Tax Paid', matchKey: '', options: [
  //             'OTT',
  //             'LTT',
  //           ]),
  //           CarPartModel(
  //               name: 'Partipeshi Request',
  //               matchKey: '',
  //               options: ['Yes', 'No']),
  //           CarPartModel(
  //               name: 'Duplicate Key', matchKey: '', options: ['Yes', 'No']),
  //           CarPartModel(
  //               name: 'Chassis Number Embossing',
  //               matchKey: '',
  //               options: [
  //                 'Ok',
  //                 'Floor Laminated',
  //                 'Rusted',
  //                 'Repunched',
  //                 'Not Traceable'
  //               ]),
  //           CarPartModel(
  //               name: 'CNG/LPG Fitment in RC',
  //               matchKey: '',
  //               options: ['Select', 'No mismatch', 'mismatch'])
  //         ]),
  //   ]
  // ];

  final List<TextFormFieldModel> _textFieldList = [
    TextFormFieldModel(
      name: 'Manufacturing Date',
      textInputType: TextInputType.name,
      hintText: 'Manufacturing Date',
      readOnly: true,
    ),
    TextFormFieldModel(
      name: 'Registration Date',
      textInputType: TextInputType.name,
      hintText: 'Registration Date',
      readOnly: true,
    ),
    TextFormFieldModel(
      name: 'Fitness Upto',
      textInputType: TextInputType.name,
      hintText: 'Fitness Upto',
      readOnly: true,
    ),
    TextFormFieldModel(
      name: 'RTO',
      textInputType: TextInputType.name,
      hintText: 'RTO',
    ),
  ];

  Future<void> getPanelDetail() async {
    showCircularProcess(context: context);
    List<InspectorCarImgInfo>? exteriorList = await ref
        .watch(apiProvider)
        .getCarVerficationPanel(
            beadingId: beadingId, activeIndex: _activeIndex);
    if (exteriorList != null) {
      for (int i = 0;
          i < ref.watch(getListOfPageProvider)[_activeIndex].length;
          i++) {
        for (int j = 0;
            j <
                ref
                    .watch(getListOfPageProvider)[_activeIndex][i]
                    .carPartList
                    .length;
            j++) {
          try {
            InspectorCarImgInfo icii = exteriorList.lastWhere((obj) {
              return obj.subtype ==
                  ref
                      .watch(getListOfPageProvider)[_activeIndex][i]
                      .carPartList[j]
                      .matchKey;
            });
            if (ref
                .watch(getListOfPageProvider)[_activeIndex][i]
                .carPartList[j]
                .options
                .contains(icii.comment)) {
              ref
                  .watch(getListOfPageProvider)[_activeIndex][i]
                  .carPartList[j]
                  .docLink = icii.documentLink;
              ref
                  .watch(getListOfPageProvider)[_activeIndex][i]
                  .carPartList[j]
                  .docId = icii.documentId;
              ref
                  .watch(getListOfPageProvider)[_activeIndex][i]
                  .carPartList[j]
                  .value = icii.comment;
            } else {
              print(
                  "${ref.watch(getListOfPageProvider)[_activeIndex][i].carPartList[j].name} = ${icii.comment}");
            }
          } catch (e) {
            continue;
          }
        }
      }
      ref.read(refreshProvider.notifier).increment();
    }
    Navigator.of(context).pop();
  }

  Future<void> getImportantDoc() async {
    showCircularProcess(context: context);
    ImpDocModel? idm = await ref.watch(apiProvider).getImpDoc(id: beadingId);
    if (idm != null) {
      this.idm = idm;
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[0]
          .options
          .contains(idm.rcavailability)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[0].value =
            idm.rcavailability;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[1]
          .options
          .contains(idm.mismatchInRC)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[1].value =
            idm.mismatchInRC;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[2]
          .options
          .contains(idm.rtonocissued)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[2].value =
            idm.rtonocissued;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[3]
          .options
          .contains(idm.insuranceType)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[3].value =
            idm.insuranceType;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[4]
          .options
          .contains(idm.noClaimBonus)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[4].value =
            idm.noClaimBonus;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[5]
          .options
          .contains(idm.loanStatus)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[5].value =
            idm.loanStatus;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[6]
          .options
          .contains(idm.underHypothecation)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[6].value =
            idm.underHypothecation;
      }

      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[7]
          .options
          .contains(idm.roadTaxPaid)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[7].value =
            idm.roadTaxPaid;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[8]
          .options
          .contains(idm.partipeshiRequest)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[8].value =
            idm.partipeshiRequest;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[9]
          .options
          .contains(idm.duplicateKey)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[9].value =
            idm.duplicateKey;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[10]
          .options
          .contains(idm.chassisNumberEmbossing)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[10].value =
            idm.chassisNumberEmbossing;
      }
      if (ref
          .watch(getListOfPageProvider)
          .last
          .first
          .carPartList[11]
          .options
          .contains(idm.cnglpgfitmentInRC)) {
        ref.watch(getListOfPageProvider).last.first.carPartList[11].value =
            idm.cnglpgfitmentInRC;
      }
      try {
        _textFieldList[0].editingController.text =
            df.format(DateTime.parse(idm.manufacturingDate));
      } catch (e) {
        _textFieldList[0].editingController.text = idm.manufacturingDate;
      }
      try {
        _textFieldList[1].editingController.text =
            df.format(DateTime.parse(idm.registrationDate));
      } catch (e) {
        _textFieldList[1].editingController.text = idm.registrationDate;
      }
      try {
        _textFieldList[2].editingController.text =
            df.format(DateTime.parse(idm.fitnessUpto));
      } catch (e) {
        _textFieldList[2].editingController.text = idm.fitnessUpto;
      }

      _textFieldList[3].editingController.text = idm.rto;
    }
    Navigator.of(context).pop();
  }

  // Future<void> getInteriorPanelDetail() async {
  //   List<InspectorCarImgInfo>? exteriorList = await ref
  //       .watch(apiProvider)
  //       .getCarVerficationPanel(
  //           beadingId: beadingId, activeIndex: _activeIndex);
  //   if (exteriorList != null) {
  //     for (int i = 0; i < ref.watch(getListOfPageProvider)[0].length; i++) {
  //       for (int j = 0; j < ref.watch(getListOfPageProvider)[0][i].carPartList.length; j++) {
  //         try {
  //           InspectorCarImgInfo icii = exteriorList.lastWhere((obj) {
  //             return obj.subtype == ref.watch(getListOfPageProvider)[0][i].carPartList[j].matchKey;
  //           });
  //           if (ref.watch(getListOfPageProvider)[0][i]
  //               .carPartList[j]
  //               .options
  //               .contains(icii.comment)) {
  //             ref.watch(getListOfPageProvider)[0][i].carPartList[j].docLink = icii.documentLink;
  //             ref.watch(getListOfPageProvider)[0][i].carPartList[j].value = icii.comment;
  //           } else {
  //             print(
  //                 "${ref.watch(getListOfPageProvider)[0][i].carPartList[j].name} = ${icii.comment}");
  //           }
  //         } catch (e) {
  //           continue;
  //         }
  //       }
  //     }
  //     ref.read(refreshProvider.notifier).increment();
  //   }
  // }

  @override
  void initState() {
    super.initState();

    beadingId = widget.beadingId;
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await getPanelDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < _textFieldList.length - 1; i++) {
      _textFieldList[i].onTap = () async {
        DateTime? pickdate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2050));
        if (pickdate != null) {
          String formatedDate = df.format(pickdate);
          _textFieldList[i].editingController.text = formatedDate;
        }
      };
    }
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Car Verification',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20.0.w(), vertical: 15.0.h()),
          child: Column(
            children: [
              SizedBox(
                height: 10.0.h(),
              ),
              Consumer(builder: (context, ref, child) {
                ref.watch(refreshProvider);
                return LinearPercentIndicator(
                  leading: Text(
                    '${_activeIndex + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Text(
                    '${7}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  lineHeight: 5.0.h(),
                  percent: (_activeIndex + 1) / 7,
                  //percent: ((100 * quesNo) / quizInfoList.length) / 100,
                  clipLinearGradient: true,
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w()),
                  animation: true,
                  backgroundColor: Colors.grey[300],
                  barRadius: Radius.circular(6.0.h()),
                  animationDuration: 2000,
                  animateFromLastPercent: true,
                  progressColor: const Color(0xFFffc000),
                );
              }),
              SizedBox(
                height: 10.0.h(),
              ),
              Consumer(builder: (context, ref, child) {
                ref.watch(refreshProvider);
                return _activeIndex != 6
                    ? Column(
                        children: ref
                            .watch(getListOfPageProvider)[_activeIndex]
                            .map((element1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                element1.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 18.0.h(),
                              ),
                              Column(
                                children: element1.carPartList.map((element2) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 24.0.h()),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Consumer(
                                            builder: (context, ref, child) {
                                          ref.watch(refresh2Provider);
                                          return DropdownButtonFormField(
                                            // padding: EdgeInsets.symmetric(
                                            //     horizontal: 55.0.w()),
                                            value: element2.value,
                                            key: element2.globalKey,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (String? val) {
                                              if (val == null || val.isEmpty) {
                                                return "Please enter valid";
                                              }
                                            },
                                            items: element2.options
                                                .map((element3) {
                                              return DropdownMenuItem(
                                                value: element3,
                                                child: Text(
                                                  element3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              if (val != null) {
                                                element2.value = val;

                                                ref
                                                    .read(refresh2Provider
                                                        .notifier)
                                                    .increment();
                                              }
                                            },
                                            // decoration: getInputDecoration2(
                                            //
                                            //     context: context, dropdownmodel: element3),
                                          );
                                        }),
                                        SizedBox(
                                          height: 10.0.h(),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (element2
                                                    .globalKey.currentState!
                                                    .validate()) {
                                                  InspectorCarImgInfo icii =
                                                      InspectorCarImgInfo(
                                                    documentType:
                                                        'InspectionReport',
                                                    doc: null,
                                                    doctype: element1.docMatch,
                                                    subtype: element2.matchKey,
                                                    comment: element2.value,
                                                    beadingCarId:
                                                        widget.beadingId,
                                                  );
                                                  showCircularProcess(
                                                      context: context);
                                                  if (await ref
                                                      .watch(apiProvider)
                                                      .addWithoutPhotoCarPart(
                                                          icii: icii)) {
                                                    showSnackBar(
                                                        color: Colors.green,
                                                        message:
                                                            'Successfully added',
                                                        context: context);
                                                  } else {
                                                    showSnackBar(
                                                        color: Colors.red,
                                                        message:
                                                            'Unsuccessfully added',
                                                        context: context);
                                                  }
                                                  await getPanelDetail();
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: Container(
                                                height: 55.0.h(),
                                                width: 100.0.w(),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.h()),
                                                    color: Colors.grey[300]),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'SUBMIT WITHOUT IMAGE',
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize: 12.0.h()),
                                                ),
                                              ),
                                            ),
                                            //if (widget.token.isInspector())
                                            InkWell(
                                              onTap: () async {
                                                if (element2
                                                    .globalKey.currentState!
                                                    .validate()) {
                                                  InspectorCarImgInfo icii =
                                                      InspectorCarImgInfo(
                                                    documentType:
                                                        'Inspection%20Report',
                                                    doc: null,
                                                    doctype: element1.docMatch,
                                                    subtype: element2.matchKey,
                                                    comment: element2.value,
                                                    beadingCarId:
                                                        widget.beadingId,
                                                  );
                                                  List<CameraDescription>
                                                      cameraList =
                                                      await availableCameras();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              CameraCaptureScreen(
                                                                  cameraList:
                                                                      cameraList,
                                                                  icii: icii)))
                                                      .then((val) {
                                                    getPanelDetail();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: 55.0.h(),
                                                width: 100.0.w(),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.h()),
                                                    color: Colors.grey[300]),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'OPEN CAMERA',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize: 13.0.h()),
                                                ),
                                              ),
                                            ),
                                            //if (widget.token.isSalesPerson())
                                            InkWell(
                                              onTap: () async {
                                                if (element2
                                                    .globalKey.currentState!
                                                    .validate()) {
                                                  InspectorCarImgInfo icii =
                                                      InspectorCarImgInfo(
                                                    documentType:
                                                        'Inspection%20Report',
                                                    doc: null,
                                                    doctype: element1.docMatch,
                                                    subtype: element2.matchKey,
                                                    comment: element2.value,
                                                    beadingCarId:
                                                        widget.beadingId,
                                                  );
                                                  File? imgFile = await addImg(
                                                      context: context);
                                                  if (imgFile != null) {
                                                    showCircularProcess(
                                                        context: context);
                                                    if (await ref
                                                        .watch(apiProvider)
                                                        .addWithPhotoCarPart(
                                                            icii: icii,
                                                            imgFile: imgFile)) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await getPanelDetail();

                                                      showSnackBar(
                                                          color: Colors.green,
                                                          message:
                                                              "Car with image Added",
                                                          context: context);
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showSnackBar(
                                                          color: Colors.red,
                                                          message:
                                                              "Car with image Added unsucessfully",
                                                          context: context);
                                                    }
                                                  }
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons
                                                      .cloud_upload_outlined),
                                                  SizedBox(
                                                    width: 8.0.w(),
                                                  ),
                                                  SizedBox(
                                                      width: 50.0.w(),
                                                      child:
                                                          Text('Upload Image'))
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                showCircularProcess(
                                                    context: context);
                                                element2.globalKey.currentState!
                                                    .reset();
                                                element2.value = null;
                                                if (element2.docLink != null) {
                                                  element2.docLink = null;
                                                  if (await ref
                                                      .watch(apiProvider)
                                                      .deleteCarPartPhoto(
                                                          docId:
                                                              element2.docId)) {
                                                    showSnackBar(
                                                        color: Colors.green,
                                                        message:
                                                            "Photo deleted",
                                                        context: context);
                                                  } else {
                                                    showSnackBar(
                                                        color: Colors.red,
                                                        message:
                                                            "Something went wrong",
                                                        context: context);
                                                  }
                                                }
                                                ref
                                                    .watch(refresh2Provider
                                                        .notifier)
                                                    .increment();
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                height: 55.0.h(),
                                                width: 100.0.w(),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 1.0.h()),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0.h()),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'REST',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize: 15.0.h(),
                                                          color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            ref.watch(refresh2Provider);
                                            if (element2.docLink != null) {
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15.0.h(),
                                                  ),
                                                  Image.network(
                                                    element2.docLink!,
                                                    height: 90.0.h(),
                                                    width: 150.0.w(),
                                                    fit: BoxFit.cover,
                                                  )
                                                ],
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          );
                        }).toList(),
                      )
                    : Column(
                        children: [
                          Text(
                            'Important Documents',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.0.h(),
                          ),
                          Column(
                            children: ref
                                .watch(getListOfPageProvider)[_activeIndex]
                                .first
                                .carPartList
                                .sublist(
                                    0,
                                    ref
                                            .watch(getListOfPageProvider)[
                                                _activeIndex]
                                            .first
                                            .carPartList
                                            .length -
                                        1)
                                .map((element) {
                              return Consumer(builder: (context, ref, child) {
                                ref.watch(refresh2Provider);
                                return DropdownButtonFormField(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0.h()),
                                  value: element.value,
                                  key: element.globalKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter valid";
                                    }
                                  },
                                  items: element.options.map((element3) {
                                    return DropdownMenuItem(
                                      value: element3,
                                      child: Text(
                                        element3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      element.value = val;

                                      ref
                                          .read(refresh2Provider.notifier)
                                          .increment();
                                    }
                                  },
                                  // decoration: getInputDecoration(
                                  //     name: element.name,
                                  //     obscureText: false,
                                  //     context: context),
                                );
                              });
                            }).toList(),
                          ),
                          Column(
                            children:
                                _textFieldList.sublist(0, 2).map((element) {
                              return GetTextFormField(textFieldModel: element);
                            }).toList(),
                          ),
                          GetTextFormField(textFieldModel: _textFieldList.last),
                          GetTextFormField(
                            textFieldModel: _textFieldList[2],
                          ),
                          Consumer(builder: (context, ref, child) {
                            CarPartModel element = ref
                                .watch(getListOfPageProvider)[_activeIndex]
                                .first
                                .carPartList
                                .last;
                            return DropdownButtonFormField(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h()),
                              value: element.value,
                              key: element.globalKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter valid";
                                }
                              },
                              items: element.options.map((element3) {
                                return DropdownMenuItem(
                                  value: element3,
                                  child: Text(
                                    element3,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  element.value = val;

                                  ref
                                      .read(refresh2Provider.notifier)
                                      .increment();
                                }
                              },
                              // decoration: getInputDecoration(
                              //     name: element.name,
                              //     obscureText: false,
                              //     context: context),
                            );
                          }),
                          SizedBox(
                            height: 15.0.h(),
                          ),
                          InkWell(
                            onTap: () async {
                              bool done = true;
                              for (TextFormFieldModel action
                                  in _textFieldList) {
                                if (!action.globalKey.currentState!
                                    .validate()) {
                                  done = false;
                                }
                              }
                              for (CarPartModel action in ref
                                  .watch(getListOfPageProvider)[_activeIndex]
                                  .first
                                  .carPartList) {
                                if (!action.globalKey.currentState!
                                    .validate()) {
                                  done = false;
                                }
                              }
                              if (done) {
                                TokenModel? token =
                                    await isAuth(context: context);
                                if (token != null) {
                                  ImpDocModel idm = ImpDocModel(
                                    inspectionReportId: -1,
                                    userId: token.userId,
                                    beadingCarId: beadingId,
                                    registrationDate: _textFieldList[1]
                                        .editingController
                                        .text
                                        .trim(),
                                    rto: _textFieldList[3]
                                        .editingController
                                        .text
                                        .trim(),
                                    fitnessUpto: _textFieldList[2]
                                        .editingController
                                        .text
                                        .trim(),
                                    cnglpgfitmentInRC: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[11]
                                        .value!,
                                    nocstatus: '',
                                    rcavailability: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[0]
                                        .value!,
                                    mismatchInRC: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[1]
                                        .value!,
                                    rtonocissued: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[2]
                                        .value!,
                                    insuranceType: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[3]
                                        .value!,
                                    noClaimBonus: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[4]
                                        .value!,
                                    underHypothecation: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[6]
                                        .value!,
                                    loanStatus: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[5]
                                        .value!,
                                    roadTaxPaid: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[7]
                                        .value!,
                                    partipeshiRequest: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[8]
                                        .value!,
                                    duplicateKey: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[9]
                                        .value!,
                                    chassisNumberEmbossing: ref
                                        .watch(getListOfPageProvider)
                                        .last
                                        .first
                                        .carPartList[10]
                                        .value!,
                                    manufacturingDate: _textFieldList[0]
                                        .editingController
                                        .text
                                        .trim(),
                                  );
                                  showCircularProcess(context: context);

                                  Map<bool, String> response = await ref
                                      .watch(apiProvider)
                                      .addUpdateInspectionReport(
                                          idm: this.idm,
                                          body: idm.toJsonAddInspector());
                                  Navigator.of(context).pop();
                                  if (response[true] != null) {
                                    showSnackBar(
                                        color: Colors.green,
                                        message: response[true]!,
                                        context: context);
                                    Navigator.of(context).pop();
                                  } else {
                                    showSnackBar(
                                        color: Colors.red,
                                        message: response[false]!,
                                        context: context);
                                  }
                                }
                              } else {
                                showSnackBar(
                                    color: Colors.red,
                                    message: 'Please fill all filed',
                                    context: context);
                              }
                            },
                            child: Container(
                              height: 47.5.h(),
                              width: 100.0.w(),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10.0.h()),
                              ),
                              child: Text(
                                "Submit",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30.0.w(), right: 5.0.w()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "1",
              onPressed: () async {
                if (_activeIndex != 0) {
                  _activeIndex--;
                  await getPanelDetail();
                  ref.read(refreshProvider.notifier).increment();
                }
              },
              backgroundColor: Colors.black54,
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: "2",
              onPressed: () async {
                if (_activeIndex != 6) {
                  bool done = true;
                  for (int i = 0;
                      i < ref.watch(getListOfPageProvider)[_activeIndex].length;
                      i++) {
                    for (int j = 0;
                        j <
                            ref
                                .watch(getListOfPageProvider)[_activeIndex][i]
                                .carPartList
                                .length;
                        j++) {
                      if (!ref
                          .watch(getListOfPageProvider)[_activeIndex][i]
                          .carPartList[j]
                          .globalKey
                          .currentState!
                          .validate()) {
                        done = false;
                      }
                    }
                  }
                  if (done) {
                    _activeIndex++;
                    if (_activeIndex != 6) {
                      await getPanelDetail();
                    } else {
                      await getImportantDoc();
                    }
                    ref.read(refreshProvider.notifier).increment();
                  } else {
                    showSnackBar(
                        color: Colors.red,
                        message: 'Please fill all filed',
                        context: context);
                  }
                }
              },
              backgroundColor: Colors.black54,
              child: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
