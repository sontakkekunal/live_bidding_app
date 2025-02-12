import 'package:dealer_caryanam/View/utility.dart';

class VehicleBiddingInfoModel {
  late int bidCarId;
  late int beadingCarId;
  late DateTime closingTime;
  late DateTime createdAt;
  late int basePrice;
  late int userId;

  VehicleBiddingInfoModel(
      {required this.bidCarId,
      required this.beadingCarId,
      required this.closingTime,
      required this.createdAt,
      required this.basePrice,
      required this.userId});

  VehicleBiddingInfoModel.fromJson(Map<String, dynamic> json) {
    bidCarId = json['bidCarId'] ?? -1;
    beadingCarId = json['beadingCarId'] ?? -1;
    closingTime = json['closingTime'] != null
        ? normalDateTime(date: json['closingTime'])
        : DateTime.now();
    createdAt = json['createdAt'] != null
        ? normalDateTime(date: json['createdAt'])
        : DateTime.now();
    basePrice = json['basePrice'] ?? -1;
    userId = json['userId'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidCarId'] = bidCarId;
    data['beadingCarId'] = beadingCarId;
    data['closingTime'] = closingTime;
    data['createdAt'] = createdAt;
    data['basePrice'] = basePrice;
    data['userId'] = userId;
    return data;
  }
}
