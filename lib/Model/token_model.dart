class TokenModel {
  late String sub;
  late String firstname;
  late int userId;
  int? userProfileId;
  int? inspectorProfileId;
  int? salesPersonId;
  int? dealerId;
  late List<String> authorities;
  late List<String> roles;
  late bool isEnable;
  late int iat;
  late int exp;
  late String originalToken;

  TokenModel(
      {required this.sub,
      required this.firstname,
      required this.userId,
      this.userProfileId,
      this.inspectorProfileId,
      this.salesPersonId,
      this.dealerId,
      required this.authorities,
      required this.roles,
      required this.isEnable,
      required this.iat,
      required this.exp,
      required this.originalToken});

  TokenModel.fromJson(Map<String, dynamic> json, this.originalToken) {
    originalToken = originalToken.replaceAll('"', '');
    sub = json['sub'];
    firstname = json['firstname'];
    if (json['salesPersonId'] != null) {
      salesPersonId = int.parse(json['salesPersonId']);
    }
    userId = int.parse(json['userId']);
    if (json['userProfileId'] != null) {
      userProfileId = int.parse(json['userProfileId']);
    }
    authorities = json['authorities'].cast<String>();
    roles = json['roles'].cast<String>();
    isEnable = json['isEnable'];
    iat = json['iat'];
    exp = json['exp'];
    if (json['inspectorProfileId'] != null) {
      inspectorProfileId = int.parse(json['inspectorProfileId']);
    }
    if (json['dealerId'] != null) {
      dealerId = int.parse(json['dealerId']);
    }
  }

  bool isDealer() {
    return roles.contains('DEALER');
  }

  bool isUser() {
    return roles.contains('USER');
  }

  bool isInspector() {
    return roles.contains('INSPECTOR');
  }

  bool isSalesPerson() {
    return roles.contains('SALESPERSON');
  }
}
