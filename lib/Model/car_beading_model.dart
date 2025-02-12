class CarBeadingModel {
  int? carId;
  bool? airbag;
  bool? buttonStart;
  bool? sunroof;
  bool? childSafetyLocks;
  bool? acFeature;
  bool? musicFeature;
  String? area;
  String? brand;
  bool? carInsurance;
  String? carStatus;
  String? city;
  String? color;
  String? description;
  String? fuelType;
  int? kmDriven;
  String? model;
  int? ownerSerial;
  bool? powerWindowFeature;
  int? price;
  bool? rearParkingCameraFeature;
  String? registration;
  String? transmission;
  int? year;
  String? date;
  int? userId;
  String? variant;
  String? title;
  int? dealerId;
  String? carInsuranceType;
  String? uniqueBeadingCarId;
  bool? abs;
  String? biddingTimerStatus;
  int? biddingTimerId;
  int? inspectionReportId;
  String? safetyDescription;

  CarBeadingModel(
      {this.carId,
      this.airbag,
      this.buttonStart,
      this.sunroof,
      this.childSafetyLocks,
      this.acFeature,
      this.musicFeature,
      this.area,
      this.brand,
      this.carInsurance,
      this.carStatus,
      this.city,
      this.color,
      this.description,
      this.fuelType,
      this.kmDriven,
      this.model,
      this.ownerSerial,
      this.powerWindowFeature,
      this.price,
      this.rearParkingCameraFeature,
      this.registration,
      this.transmission,
      this.year,
      this.date,
      this.userId,
      this.variant,
      this.title,
      this.dealerId,
      this.inspectionReportId,
      this.carInsuranceType,
      this.uniqueBeadingCarId,
      this.biddingTimerStatus,
      this.biddingTimerId,
      this.safetyDescription,
      this.abs});

  CarBeadingModel.fromJson(Map<String, dynamic> json) {
    carId = json['carId'] ?? -1;
    airbag = json['airbag'];
    buttonStart = json['buttonStart'];
    sunroof = json['sunroof'];
    childSafetyLocks = json['childSafetyLocks'];
    acFeature = json['acFeature'];
    musicFeature = json['musicFeature'];
    area = json['area'];
    brand = json['brand'];
    carInsurance = json['carInsurance'];
    carStatus = json['carStatus'];
    city = json['city'];
    color = json['color'];
    description = json['description'];
    fuelType = json['fuelType'];
    kmDriven = json['kmDriven'];
    model = json['model'];
    ownerSerial = json['ownerSerial'];
    powerWindowFeature = json['powerWindowFeature'];
    price = json['price'];
    rearParkingCameraFeature = json['rearParkingCameraFeature'];
    registration = json['registration'];
    transmission = json['transmission'];
    year = json['year'];
    date = json['date'];
    safetyDescription = json['safetyDescription'];
    userId = json['userId'];

    variant = json['variant'];
    title = json['title'];
    dealerId = json['dealerId'];
    carInsuranceType = json['carInsuranceType'];
    uniqueBeadingCarId = json['uniqueBeadingCarId'];
    abs = json['abs'];
    inspectionReportId = json['inspectionReportId'];
    biddingTimerId = json['biddingTimerId'];
    biddingTimerStatus = json['biddingTimerStatus'];
  }
}

class InspectorCarImgInfo {
  String? documentType;
  String? documentLink;
  String? doc;
  int? beadingCarId;
  String? doctype;
  String? subtype;
  String? comment;
  int? documentId;

  InspectorCarImgInfo(
      {this.documentType,
      this.documentLink,
      this.doc,
      this.beadingCarId,
      this.doctype,
      this.subtype,
      this.comment,
      this.documentId});

  InspectorCarImgInfo.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    documentLink = json['documentLink'];
    doc = json['doc'];
    beadingCarId = json['beadingCarId'];
    doctype = json['documentType'];

    subtype = json['subtype'];
    comment = json['comment'];
    documentId = json['documentId'];
    print(json);
  }
}
