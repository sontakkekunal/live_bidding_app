class LiveBidModel {
  late int placedBidId;
  late int userId;
  late int bidCarId;
  late DateTime dateTime;
  late int amount;

  LiveBidModel(
      {required this.placedBidId,
      required this.userId,
      required this.bidCarId,
      required this.dateTime,
      required this.amount});

  LiveBidModel.fromJson(Map<String, dynamic> json) {
    placedBidId = json['placedBidId'] ?? -1;
    userId = json['userId'] ?? -1;
    bidCarId = json['bidCarId'] ?? -1;
    dateTime = json['dateTime'] != null
        ? DateTime.parse(json['dateTime'])
        : DateTime.now();
    amount = json['amount'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placedBidId'] = placedBidId;
    data['userId'] = userId;
    data['bidCarId'] = bidCarId;
    data['dateTime'] = dateTime;
    data['amount'] = amount;
    return data;
  }
}
