class FinalBidsModel {
  late int finalBidId;
  late int sellerDealerId;
  late int buyerDealerId;
  late int bidCarId;
  late int price;
  late int beadingCarId;

  FinalBidsModel(
      {required this.finalBidId,
      required this.sellerDealerId,
      required this.buyerDealerId,
      required this.bidCarId,
      required this.price,
      required this.beadingCarId});

  FinalBidsModel.fromJson(Map<String, dynamic> json) {
    finalBidId = json['finalBidId'];
    sellerDealerId = json['sellerDealerId'];
    buyerDealerId = json['buyerDealerId'];
    bidCarId = json['bidCarId'];
    price = json['price'];
    beadingCarId = json['beadingCarId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finalBidId'] = this.finalBidId;
    data['sellerDealerId'] = this.sellerDealerId;
    data['buyerDealerId'] = this.buyerDealerId;
    data['bidCarId'] = this.bidCarId;
    data['price'] = this.price;
    data['beadingCarId'] = this.beadingCarId;
    return data;
  }
}
