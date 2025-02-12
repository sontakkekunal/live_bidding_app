import 'dart:convert';
import 'dart:io';

import 'package:dealer_caryanam/Model/bids_with_vehicle_model.dart';
import 'package:dealer_caryanam/Model/live_bid_model.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/Model/vehicle_bidding_info_model.dart';
import 'package:dealer_caryanam/Model/vehicle_model.dart';
import 'package:dealer_caryanam/Model/vehicle_winner_model.dart';
import 'package:dealer_caryanam/View/winner_vehicle_screen.dart';
import 'package:http/http.dart' as http;

import '../Model/car_beading_model.dart';
import '../Model/imp_doc_model.dart';
import '../Model/registration_response_model.dart';

class ApiService {
  // static const String mainEndPoint =
  //     'https://caryanamtestingspringboot-production.up.railway.app/';
  static const String mainEndPoint = 'https://addd.prodchunca.in.net/';

  Future<Map<String, dynamic>> _postCall(
      {required String endpoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(endpoint);

    http.Response response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> loginCall({required Map<String, dynamic> body}) async {
    String endpoint = '${mainEndPoint}jwt/login';
    try {
      final dynamic response =
          await _postLoginCall(endpoint: endpoint, body: body);
      print("kkkk");
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> _postLoginCall(
      {required String endpoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(endpoint);

    http.Response response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print("statusCode");

    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      print("in this");
      // return TokenModel.fromJson(jsonDecode(response.body), response.body);
      return RegistrationResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String, dynamic>> _getCall({required String endPoint}) async {
    Uri url = Uri.parse(endPoint);

    try {
      http.Response response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return {};
  }

  Future<Map<String, dynamic>> _getCallWithAuth(
      {required String endPoint, required String authToken}) async {
    Uri url = Uri.parse(endPoint);

    try {
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }

    return {};
  }

  Future<List<BidsWithVehicleModel>> finalBidsWithVehicleList(
      {required int dealerId, required int pageNo}) async {
    String endPoint =
        '${mainEndPoint}Bid/getAllDealerFinalBids?buyerDealerId=$dealerId&pageNo=$pageNo&pageSize=50';
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      List<FinalBidsModel> list =
          List.generate(map['finalBids'].length, (int index) {
        FinalBidsModel fdm = FinalBidsModel.fromJson(map['finalBids'][index]);
        return fdm;
      });
      List<BidsWithVehicleModel> finalList = [];
      for (FinalBidsModel fbm in list) {
        VehicleModel? vm = await getVehicleById(id: fbm.beadingCarId);
        if (vm == null) {
          throw Exception("Car Info Not found");
        }
        finalList
            .add(BidsWithVehicleModel(vehicleModel: vm, finalBidsModel: fbm));
      }
      return finalList;
    } else {
      throw Exception('Data Not Sound');
    }
  }

  Future<List<ImageInfoModel>?> vehicleImg({required int carId}) async {
    String endPoint =
        "${mainEndPoint}uploadFileBidCar/getDocuments?beadingCarId=$carId&DocumentType=coverImage";
    //String endPoint = '${mainEndPoint}uploadFile/getByCarID?carId=$carId';

    Map<String, dynamic> json2 = await _getCall(endPoint: endPoint);
    if (json2.isNotEmpty) {
      List<dynamic> list = json2['object'].map((element) {
        return ImageInfoModel.fromJson(element);
      }).toList();
      return list.cast<ImageInfoModel>();
    }
    return null;
  }

  Future<List<ImageInfoModel2>?> vehicleImgModel2({required int carId}) async {
    String endPoint =
        "${mainEndPoint}uploadFileBidCar/getDocuments?beadingCarId=$carId&DocumentType=coverImage";
    //String endPoint = '${mainEndPoint}uploadFile/getByCarID?carId=$carId';
    endPoint =
        "${mainEndPoint}uploadFileBidCar/getByBidCarID?beadingCarId=$carId";

    Map<String, dynamic> json2 = await _getCall(endPoint: endPoint);
    if (json2.isNotEmpty) {
      List<dynamic> list = json2['object'].map((element) {
        return ImageInfoModel2.fromJson(element);
      }).toList();
      return list.cast<ImageInfoModel2>();
    }
    return null;
  }

  Future<List<VehicleBiddingInfoModel>> biddingLiveCar(
      {required String token}) async {
    String endPoint = "${mainEndPoint}biddingHTTP/liveCars";
    Uri url = Uri.parse(endPoint);
    http.Response response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      return List.generate(list.length, (i) {
        return VehicleBiddingInfoModel.fromJson(list[i]);
      });
    } else {
      throw Exception(response.body);
    }
  }

  Future<VehicleBiddingInfoModel?> biddingLiveCarSpecfic(
      {required int id}) async {
    String endPoint = "${mainEndPoint}biddingHTTP/liveCars/$id";
    Uri url = Uri.parse(endPoint);
    http.Response response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      return VehicleBiddingInfoModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<VehicleModel?> getVehicleById({required int id}) async {
    String endPoint = "${mainEndPoint}BeadingCarController/getbyId/$id";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      return VehicleModel.fromJson(map);
    }
    return null;
  }

  Future<Map<String, dynamic>> _postCallComman(
      {required String endPoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      print("My status ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<bool> requestBooking({required Map<String, dynamic> body}) async {
    String endPoint = '${mainEndPoint}booking/request';
    Map<String, dynamic> val =
        await _postCallComman(endPoint: endPoint, body: body);
    if (val.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser({required Map<String, dynamic> body}) async {
    String endPoint = "${mainEndPoint}user/edit/${body['id']}";

    Map<String, dynamic> map =
        await _putApiCall(endPoint: endPoint, body: body);

    if (map.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<bool, String>> addUpdateInspectionReport(
      {required Map<String, dynamic> body, ImpDocModel? idm}) async {
    String endPoint = "${mainEndPoint}inspectionReport/add";
    try {
      print(body.toString());
      http.Response response = await http.post(Uri.parse(endPoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {true: "Inspector car added successfully"};
      } else if (response.statusCode == 406 && idm != null) {
        print(idm.inspectionReportId);
        String endPoint2 =
            "${mainEndPoint}inspectionReport/edit?inspectionReportId=${idm.inspectionReportId}";
        http.Response response2 = await http.patch(Uri.parse(endPoint2),
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'});
        print(response2.statusCode);
        if (response2.statusCode == 200) {
          return {true: "Inspector car updated successfully"};
        }
      } else {
        print("gere1");
        return {false: "Something went wrong..."};
      }
    } catch (e) {
      print("gere2");
      return {false: "Something went wrong..."};
    }
    print("gere13");
    return {false: "Something went wrong..."};
  }

  Future<bool> addWithoutPhotoCarPart(
      {required InspectorCarImgInfo icii}) async {
    String endPoint =
        "${mainEndPoint}uploadFileBidCar/addWithoutPhoto?documentType=${icii.documentType}&doc=${icii.doc}&doctype=${icii.doctype}&subtype=${icii.subtype}&comment=${icii.comment}&beadingCarId=${icii.beadingCarId}";

    try {
      Map<String, dynamic> map =
          await _postCallComman(endPoint: endPoint, body: {});
      return map.isNotEmpty;
      //http.Response response=http.post(Uri.parse(endPoint))
    } catch (e) {
      return false;
    }
  }

  Future<bool> addWithPhotoCarPart(
      {required InspectorCarImgInfo icii, required File imgFile}) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(
          '${mainEndPoint}uploadFileBidCar/add?documentType=${icii.documentType}&beadingCarId=${icii.beadingCarId}&doc=${icii.doc}&doctype=${icii.doctype}&subtype=${icii.subtype}&comment=${icii.comment}'),
    );
    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imgFile.path,
        ),
      );
      http.StreamedResponse response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<LiveBidModel?> bidCarById({required int id}) async {
    String endPoint = "${mainEndPoint}Bid/car/$id";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);

    if (map.isNotEmpty) {
      List list = map['placedBids'];
      if (list.isNotEmpty) {
        return LiveBidModel.fromJson(list.last);
      }
    }
    return null;
  }

  Future<ImpDocModel?> getImpDoc({required int id}) async {
    String endPoint =
        "${mainEndPoint}inspectionReport/getByBeadingCar?beadingCarId=$id";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      return ImpDocModel.fromJson(map["object"]);
    }
    return null;
  }

  Future<List<InspectorCarImgInfo>?> getCarVerficationPanel(
      {required int beadingId, required int activeIndex}) async {
    String endPoint;
    if (activeIndex == 0) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=Exterior";
    } else if (activeIndex == 1) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=Interior";
    } else if (activeIndex == 2) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=Engine";
    } else if (activeIndex == 3) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=AC";
    } else if (activeIndex == 4) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=Eletrical";
    } else if (activeIndex == 5) {
      endPoint =
          "${mainEndPoint}uploadFileBidCar/getBidCarIdType?beadingCarId=$beadingId&docType=Steering";
    } else {
      endPoint = "";
    }
    //print("ac");

    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    print("$activeIndex==== $map");
    if (map.isNotEmpty) {
      return List.generate(map["object"].length, (int index) {
        return InspectorCarImgInfo.fromJson(map["object"][index]);
      });
    } else {
      return null;
    }
  }

  Future<bool> updateInspector({required Map<String, dynamic> body}) async {
    String endPoint =
        "${mainEndPoint}ispProfile/update?inspectorProfileId=${body['inspectorProfileId']}";
    Map<String, dynamic> map =
        await _patchApiCall(endPoint: endPoint, body: body);
    return map.isNotEmpty;
  }

  Future<bool> updateSeller({required Map<String, dynamic> body}) async {
    String endPoint =
        "${mainEndPoint}salesPerson/updateSPersonDetails?salesPersonId=${body['salesPersonId']}";
    Map<String, dynamic> map =
        await _patchApiCall(endPoint: endPoint, body: body);
    return map.isNotEmpty;
  }

  Future<Map<String, dynamic>> _patchApiCall(
      {required String endPoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.patch(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return {};
    }
    return {};
  }

  Future<Map<String, dynamic>> _putApiCall(
      {required String endPoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.put(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<bool> placeBid(
      {required Map<String, dynamic> body,
      required int bidCarId,
      required String token}) async {
    String endPoint = "${mainEndPoint}Bid/placeBid?bidCarId=$bidCarId";
    print("now");
    print(token);
    print(body);

    http.Response response =
        await http.post(Uri.parse(endPoint), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token',
    });
    print("Post stuts: ${response.statusCode}");
    return response.statusCode == 200;
  }

  Future<bool> addProfileImg(
      {required File imgFile, required int userProfileId}) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('${mainEndPoint}ProfilePhoto/add?userId=$userProfileId'),
    );
    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imgFile.path,
        ),
      );
      http.StreamedResponse response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProfileImg({required int userProfileId}) async {
    String endPoint =
        '${mainEndPoint}ProfilePhoto/deletebyuserid?userId=$userProfileId';
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>?> getAllBrandName() async {
    String endPoint = "${mainEndPoint}brands/only-brands";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      return List.generate(map['list'].length, (int i) {
        return map['list'][i]["brand"];
      });
    } else {
      return null;
    }
  }

  Future<List<String>?> getVarientByBrand({required String brandName}) async {
    brandName = brandName.replaceAll(' ', '+');
    String endPoint = "${mainEndPoint}brands/variants?brand=$brandName";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      Set<String> set = {};
      for (int i = 0; i < map['list'].length; i++) {
        set.add(map['list'][i]["variant"]);
      }
      return set.toList();
    } else {
      return null;
    }
  }

  Future<List<String>?> _getSubVarient(
      {required String brandName, required String varient}) async {
    varient = varient.replaceAll(' ', '+');
    brandName = brandName.replaceAll(' ', '+');
    String endPoint =
        "${mainEndPoint}brands/sub-variants?brand=$brandName&variant=$varient";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      Set<String> set = {};
      for (int i = 0; i < map['list'].length; i++) {
        set.add(map['list'][i]["subVariant"]);
      }
      return set.toList();
    } else {
      return null;
    }
  }

  Future<List<String>> getSubVarient(
      {required String brandName, required List<String> varientList}) async {
    Set<String> set = {};
    for (int i = 0; i < varientList.length; i++) {
      List<String>? list =
          await _getSubVarient(brandName: brandName, varient: varientList[i]);
      if (list != null) {
        set.addAll(list);
      }
    }

    return set.toList();
  }

  Future<int> registercar({required Map<String, dynamic> body}) async {
    //String endPoint = "https://becar.up.railway.app/car/carregister";
    String endPoint = "${mainEndPoint}car/carregister";
    Map<String, dynamic> map =
        await _postCallComman(endPoint: endPoint, body: body);
    if (map.isNotEmpty) {
      return int.parse(map["message"]);
    } else {
      return -1;
    }
  }

  Future<bool> addCoverImg(
      {required File imgFile,
      required int beadingCarId,
      required String userId}) async {
    String endPoint =
        "${mainEndPoint}uploadFile/add?documentType=coverImage&userId=$userId&carId=$beadingCarId";
    // String endPoint =
    //     "${mainEndPoint}uploadFile/add?documentType=coverImage&userId=$userId&carId=$beadingCarId";
    //'${mainEndPoint}uploadFileBidCar/add?documentType=coverImage&beadingCarId=$beadingCarId&doc=&doctype=coverImage&subtype=coverimage&comment=ABCD'
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(endPoint),
    );
    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imgFile.path,
        ),
      );
      http.StreamedResponse response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addSideBindingImg(
      {required File imgFile,
      required int beadingCarId,
      required int userId}) async {
    String endPoint =
        "${mainEndPoint}uploadFile/add?documentType=image&userId=$userId&carId=$beadingCarId";
    //'${mainEndPoint}uploadFileBidCar/add?documentType=image&beadingCarId=$beadingCarId&doc=&doctype=image&subtype=images&comment=ABCD'
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(endPoint),
    );

    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imgFile.path,
        ),
      );
      http.StreamedResponse response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteInspectorImg({required int imgId}) async {
    String endPoint =
        "${mainEndPoint}uploadFile/deleteDocumentId?DocumentId=$imgId";
    // String endPoint =
    //     "${mainEndPoint}uploadFileBidCar/delete?DocumentId=$imgId";
    Map<String, dynamic> map = await _deleteCall(endPoint: endPoint);
    return map.isNotEmpty;
  }

  Future<Map<String, dynamic>> _deleteCall({required String endPoint}) async {
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.delete(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return {};
    }
    return {};
  }

  Future<bool> updateCar(
      {required int id,
      required Map<String, dynamic> body,
      required TokenModel token}) async {
    String endPoint = "${mainEndPoint}car/edit/$id";
    //endPoint = "https://becar.up.railway.app/car/edit/662";
    // Map<String, dynamic> map =
    //     await _putApiCall(endPoint: endPoint, body: body);
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response =
          await http.put(url, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return true;
        return jsonDecode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
    //return map.isNotEmpty;
  }

  Future<bool> deleteCarPartPhoto({required docId}) async {
    String endPoint =
        "${mainEndPoint}uploadFileBidCar/delete?DocumentId=$docId";
    Uri url = Uri.parse(endPoint);
    try {
      http.Response response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDealer({required Map<String, dynamic> body}) async {
    String endPoint = "${mainEndPoint}dealer/updateDealer/${body['userid']}";
    Map<String, dynamic> map =
        await _putApiCall(endPoint: endPoint, body: body);
    return map.isNotEmpty;
  }

  Future<bool> updateDealerStatus(
      {required int id, required bool status}) async {
    String endPoint =
        "${mainEndPoint}dealer/statusUpdate?dealerId=$id&status=$status";
    http.Response response = await http.patch(
      Uri.parse(endPoint),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  Future<String?> setBidTime({required Map<String, dynamic> body}) async {
    String endPoint = "${mainEndPoint}Bidding/v1/SetTime";
    http.Response response = await http.post(Uri.parse(endPoint),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    dynamic map = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(map)['status'];
    } else if (response.statusCode == 400) {
      return jsonDecode(map)['exception'];
    } else {
      return map.toString();
    }
  }

  Future<String?> confirmBooking({required Map<String, dynamic> body}) async {
    String endPoint = "${mainEndPoint}confirmBooking/book";
    try {
      http.Response response = await http.post(Uri.parse(endPoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      Map<String, dynamic> map = jsonDecode(response.body);

      return map['exception'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> cancelBooking({required int id}) async {
    String endPoint = "${mainEndPoint}confirmBooking/cancelStatusSet?id=$id";
    try {
      http.Response response = await http.put(
        Uri.parse(endPoint),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<int>> countCarStatus({required int dealerId}) async {
    String status = "ACTIVE";
    String endPoint =
        "${mainEndPoint}car/count?carStatus=$status&dealerId=$dealerId";

    List<int> countCarStatusList = [];

    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      countCarStatusList.add(map['object']);
    } else {
      throw Exception('Something went wrong');
    }
    status = "PENDING";
    endPoint = "${mainEndPoint}car/count?carStatus=$status&dealerId=$dealerId";
    map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      countCarStatusList.add(map['object']);
    } else {
      throw Exception('Something went wrong');
    }
    status = "DEACTIVATE";
    endPoint = "${mainEndPoint}car/count?carStatus=$status&dealerId=$dealerId";
    map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      countCarStatusList.add(map['object']);
    } else {
      throw Exception('Something went wrong');
    }
    status = "SOLD";
    endPoint = "${mainEndPoint}car/count?carStatus=$status&dealerId=$dealerId";
    map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      countCarStatusList.add(map['object']);
    } else {
      throw Exception('Something went wrong');
    }

    if (countCarStatusList.length == 4) {
      return countCarStatusList;
    } else {
      throw Exception('List not fetched properly');
    }
  }

  Future<List<String>> getAllColor() async {
    String endPoint = "${mainEndPoint}colors/getAll";
    Map<String, dynamic> map = await _getCall(endPoint: endPoint);
    if (map.isNotEmpty) {
      return List.generate(map['list'].length, (i) {
        return map['list'][i]['name'];
      });
    } else {
      return [];
    }
  }
}
