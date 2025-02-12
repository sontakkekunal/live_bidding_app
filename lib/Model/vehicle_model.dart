import 'package:dealer_caryanam/Model/questions_model.dart';
import 'package:flutter/material.dart';

class VehicleModel {
  late int beadingCarId;
  late bool airbag;
  late bool buttonStart;
  late bool sunroof;
  late bool childSafetyLocks;
  late bool acFeature;
  late bool musicFeature;
  late String area;
  late String brand;
  late bool carInsurance;
  late String carStatus;
  late String city;
  late String color;
  late String description;
  late String fuelType;
  late int kmDriven;
  late String model;
  late int ownerSerial;
  late bool powerWindowFeature;
  late int price;
  late bool rearParkingCameraFeature;
  late String registration;
  late String transmission;
  late dynamic biddingTimerId;
  late int year;
  late String date;
  late int userId;
  late String variant;
  late String title;
  late int dealerId;
  late dynamic inspectionReportId;
  late String carInsuranceType;
  late String biddingTimerStatus;
  late String uniqueBeadingCarId;
  late bool abs;
  List<dynamic>? imgInfoList;

  VehicleModel(
      {required this.beadingCarId,
      required this.airbag,
      required this.buttonStart,
      required this.sunroof,
      required this.childSafetyLocks,
      required this.acFeature,
      required this.musicFeature,
      required this.area,
      required this.brand,
      required this.carInsurance,
      required this.carStatus,
      required this.city,
      required this.color,
      required this.description,
      required this.fuelType,
      required this.kmDriven,
      required this.model,
      required this.ownerSerial,
      required this.powerWindowFeature,
      required this.price,
      required this.rearParkingCameraFeature,
      required this.registration,
      required this.transmission,
      required this.biddingTimerId,
      required this.year,
      required this.date,
      required this.userId,
      required this.variant,
      required this.title,
      required this.dealerId,
      required this.inspectionReportId,
      required this.carInsuranceType,
      required this.biddingTimerStatus,
      required this.uniqueBeadingCarId,
      this.imgInfoList,
      required this.abs});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    beadingCarId = json['beadingCarId'] ?? -1;
    airbag = json['airbag'] ?? false;
    buttonStart = json['buttonStart'] ?? false;
    sunroof = json['sunroof'] ?? false;
    childSafetyLocks = json['childSafetyLocks'] ?? false;
    acFeature = json['acFeature'] ?? false;
    musicFeature = json['musicFeature'] ?? false;
    area = json['area'] ?? "No data";
    brand = json['brand'] ?? "No data";
    carInsurance = json['carInsurance'] ?? false;
    carStatus = json['carStatus'] ?? "No data";
    city = json['city'] ?? "No data";
    color = json['color'] ?? "No data";
    description = json['description'] ?? "No data";
    fuelType = json['fuelType'] ?? "No data";
    kmDriven = json['kmDriven'] ?? -1;
    model = json['model'] ?? "No data";
    ownerSerial = json['ownerSerial'] ?? -1;
    powerWindowFeature = json['powerWindowFeature'] ?? false;
    price = json['price'] ?? -1;
    rearParkingCameraFeature = json['rearParkingCameraFeature'] ?? false;
    registration = json['registration'] ?? "No data";
    transmission = json['transmission'] ?? "No data";
    biddingTimerId = json['biddingTimerId'] ?? "No data";
    year = json['year'] ?? -1;
    date = json['date'] ?? -1;
    userId = json['userId'] ?? -1;
    variant = json['variant'] ?? "No data";
    ;
    title = json['title'] ?? "No data";
    ;
    dealerId = json['dealerId'] ?? -1;
    inspectionReportId = json['inspectionReportId'] ?? "No data";
    carInsuranceType = json['carInsuranceType'] ?? "No data";
    biddingTimerStatus = json['biddingTimerStatus'] ?? "No data";
    uniqueBeadingCarId = json['uniqueBeadingCarId'] ?? "No data";
    abs = json['abs'] ?? false;
    if (json['object'] != null) {
      imgInfoList = <ImageInfoModel>[];
      json['object'].forEach((v) {
        imgInfoList!.add(ImageInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beadingCarId'] = beadingCarId;
    data['airbag'] = airbag;
    data['buttonStart'] = buttonStart;
    data['sunroof'] = sunroof;
    data['childSafetyLocks'] = childSafetyLocks;
    data['acFeature'] = acFeature;
    data['musicFeature'] = musicFeature;
    data['area'] = area;
    data['brand'] = brand;
    data['carInsurance'] = carInsurance;
    data['carStatus'] = carStatus;
    data['city'] = city;
    data['color'] = color;
    data['description'] = description;
    data['fuelType'] = fuelType;
    data['kmDriven'] = kmDriven;
    data['model'] = model;
    data['ownerSerial'] = ownerSerial;
    data['powerWindowFeature'] = powerWindowFeature;
    data['price'] = price;
    data['rearParkingCameraFeature'] = rearParkingCameraFeature;
    data['registration'] = registration;
    data['transmission'] = transmission;
    data['biddingTimerId'] = biddingTimerId;
    data['year'] = year;
    data['date'] = date;
    data['userId'] = userId;
    data['variant'] = variant;
    data['title'] = title;
    data['dealerId'] = dealerId;
    data['inspectionReportId'] = inspectionReportId;
    data['carInsuranceType'] = carInsuranceType;
    data['biddingTimerStatus'] = biddingTimerStatus;
    data['uniqueBeadingCarId'] = uniqueBeadingCarId;
    data['abs'] = abs;
    return data;
  }

  List<QuestionsModel> getKnowCarList() {
    return <QuestionsModel>[
      QuestionsModel(
          question: 'Reg Num: ',
          answer: registration,
          extraVar: Icons.directions_car),
      QuestionsModel(
          question: 'Make year: ',
          answer: year.toString(),
          extraVar: Icons.access_time_outlined),
      QuestionsModel(
          question: 'Fuel Type: ',
          answer: fuelType,
          extraVar: Icons.local_gas_station),
      QuestionsModel(
          question: 'Transmission: ',
          answer: transmission,
          extraVar: Icons.account_tree_rounded),
      QuestionsModel(
          question: 'KM Driven: ',
          answer: "$kmDriven km",
          extraVar: Icons.speed_outlined),
      QuestionsModel(
          question: "Ownership: ",
          answer: ownerSerial.toString(),
          extraVar: Icons.person),
      QuestionsModel(
          question: 'Date: ', answer: date, extraVar: Icons.calendar_today),
      QuestionsModel(
          question: "Parked At: ",
          answer: "$area , $city",
          extraVar: Icons.location_on)
    ];
  }

  // List<List<dynamic>> getTopFeatures() {
  //   List<List<dynamic>> list = [];
  //
  //   void addIt({required dynamic data}) {
  //     if (list.isEmpty) {
  //       list.add(<dynamic>[data]);
  //     } else {
  //       if (list.last.length == 2) {
  //         list.add(<dynamic>[data]);
  //       } else {
  //         list.last.add(data);
  //       }
  //     }
  //   }
  //
  //   if (airbag == true) {
  //     addIt(data: 'Air Bag');
  //   }
  //   if (buttonStart == true) {
  //     addIt(data: 'ButtonStart');
  //   }
  //   if (sunroof == true) {
  //     addIt(data: 'Sunroof');
  //   }
  //   if (childSafetyLocks == true) {
  //     addIt(data: 'Child Safety Locks');
  //   }
  //   if (rearParkingCameraFeature == true) {
  //     addIt(data: 'Rear Parking Camera Feature');
  //   }
  //   if (acFeature == true) {
  //     addIt(data: 'Air Conditioning');
  //   }
  //   if (musicFeature == true) {
  //     addIt(data: 'Music Feature');
  //   }
  //   if (powerWindowFeature == true) {
  //     addIt(data: 'Power Window Feature');
  //   }
  //
  //   if (abs == true) {
  //     addIt(data: 'ABS');
  //   }
  //   return list;
  // }
  List<QuestionsModel> getCarTopFeatures() {
    List<QuestionsModel> list = [];
    if (airbag == true) {
      list.add(QuestionsModel(
          question: 'Air Bag',
          answer: '',
          extraVar: Icons.airplanemode_active));
    }
    if (buttonStart == true) {
      list.add(QuestionsModel(
          question: 'ButtonStart', answer: '', extraVar: Icons.play_arrow));
    }
    if (sunroof == true) {
      list.add(QuestionsModel(
          question: 'Sunroof', answer: '', extraVar: Icons.sunny));
    }
    if (childSafetyLocks == true) {
      list.add(QuestionsModel(
          question: 'Child Safety Locks', answer: '', extraVar: Icons.lock));
    }
    if (rearParkingCameraFeature == true) {
      list.add(QuestionsModel(
          question: 'Rear Parking Camera Feature',
          answer: '',
          extraVar: Icons.camera_rear));
    }
    if (acFeature == true) {
      list.add(QuestionsModel(
          question: 'Air Conditioning', answer: '', extraVar: Icons.ac_unit));
    }
    if (musicFeature == true) {
      list.add(QuestionsModel(
          question: 'Music Feature', answer: '', extraVar: Icons.music_note));
    }
    if (powerWindowFeature == true) {
      list.add(QuestionsModel(
          question: 'Power Window Feature',
          answer: '',
          extraVar: Icons.safety_check));
    }

    if (abs == true) {
      list.add(
          QuestionsModel(question: 'ABS', answer: '', extraVar: Icons.window));
    }
    return list;
  }

  List<List<QuestionsModel>> getTopFeatures() {
    List<List<QuestionsModel>> list = [];

    void addIt({required QuestionsModel data}) {
      if (list.isEmpty) {
        list.add(<QuestionsModel>[data]);
      } else {
        if (list.last.length == 2) {
          list.add(<QuestionsModel>[data]);
        } else {
          list.last.add(data);
        }
      }
    }

    if (airbag == true) {
      addIt(
          data: QuestionsModel(
              question: 'Air Bag',
              answer: '',
              extraVar: Icons.airplanemode_active));
    }
    if (buttonStart == true) {
      addIt(
          data: QuestionsModel(
              question: 'ButtonStart', answer: '', extraVar: Icons.play_arrow));
    }
    if (sunroof == true) {
      addIt(
          data: QuestionsModel(
              question: 'Sunroof', answer: '', extraVar: Icons.sunny));
    }
    if (childSafetyLocks == true) {
      addIt(
          data: QuestionsModel(
              question: 'Child Safety Locks',
              answer: '',
              extraVar: Icons.lock));
    }
    if (rearParkingCameraFeature == true) {
      addIt(
          data: QuestionsModel(
              question: 'Rear Parking Camera Feature',
              answer: '',
              extraVar: Icons.camera_rear));
    }
    if (acFeature == true) {
      addIt(
          data: QuestionsModel(
              question: 'Air Conditioning',
              answer: '',
              extraVar: Icons.ac_unit));
    }
    if (musicFeature == true) {
      addIt(
          data: QuestionsModel(
              question: 'Music Feature',
              answer: '',
              extraVar: Icons.music_note));
    }
    if (powerWindowFeature == true) {
      addIt(
          data: QuestionsModel(
              question: 'Power Window Feature',
              answer: '',
              extraVar: Icons.safety_check));
    }

    if (abs == true) {
      addIt(
          data: QuestionsModel(
              question: 'ABS', answer: '', extraVar: Icons.window));
    }
    return list;
  }
}

class ImageInfoModel {
  late dynamic documentType;
  late dynamic documentLink;
  late int userId;
  late int carId;
  late int documentId;

  ImageInfoModel(
      {required this.documentType,
      required this.documentLink,
      required this.userId,
      required this.carId,
      required this.documentId});

  ImageInfoModel.fromJson(Map<dynamic, dynamic> json) {
    documentType = json['documentType'];
    documentLink = json['documentLink'];
    userId = json['userId'];
    carId = json['carId'];
    documentId = json['documentId'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['documentType'] = documentType;
    data['documentLink'] = documentLink;
    data['userId'] = userId;
    data['carId'] = carId;
    data['documentId'] = documentId;
    return data;
  }
}

class ImageInfoModel2 {
  String? documentType;
  String? documentLink;
  String? doc;
  int? beadingCarId;
  String? doctype;
  String? subtype;
  String? comment;
  int? documentId;

  ImageInfoModel2(
      {this.documentType,
      this.documentLink,
      this.doc,
      this.beadingCarId,
      this.doctype,
      this.subtype,
      this.comment,
      this.documentId});

  ImageInfoModel2.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    documentLink = json['documentLink'];
    doc = json['doc'];
    beadingCarId = json['beadingCarId'];
    doctype = json['doctype'];
    subtype = json['subtype'];
    comment = json['comment'];
    documentId = json['documentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['documentLink'] = this.documentLink;
    data['doc'] = this.doc;
    data['beadingCarId'] = this.beadingCarId;
    data['doctype'] = this.doctype;
    data['subtype'] = this.subtype;
    data['comment'] = this.comment;
    data['documentId'] = this.documentId;
    return data;
  }
}
