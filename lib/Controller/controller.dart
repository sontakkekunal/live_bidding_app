import 'dart:developer';

import 'package:dealer_caryanam/Controller/api_service.dart';
import 'package:dealer_caryanam/Controller/shared_service.dart';
import 'package:dealer_caryanam/Model/pass_model.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class VisibilityNotifier extends _$VisibilityNotifier {
  @override
  bool build() {
    return true;
  }

  void change() {
    state = !state;
  }
}

@riverpod
class VisibilityNotifier2 extends _$VisibilityNotifier2 {
  @override
  bool build() {
    return true;
  }

  void change() {
    state = !state;
  }
}
final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});
@riverpod
class PassValue extends _$PassValue {
  @override
  List<PassModel> build() {
    return [
      PassModel(msg: "between 9 to 64 characters"),
      PassModel(msg: "at least two Upper case characters"),
      PassModel(msg: "at least two Lower case characters"),
      PassModel(msg: "at least two number characters"),
      PassModel(msg: "at least two special characterbf")
    ];
  }
}

bool checkPass(String pass, List<PassModel> list) {
  list[0].value = pass.length > 8 && pass.length < 65;
  int upCount = 0;
  int lowCount = 0;
  int numCount = 0;
  int specCount = 0;
  for (int i = 0; i < pass.length; i++) {
    int ascii = pass.codeUnitAt(i);
    if (ascii >= 65 && ascii <= 90) {
      upCount++;
    }
    if (ascii >= 97 && ascii <= 122) {
      lowCount++;
    }
    if (ascii >= 48 && ascii <= 57) {
      numCount++;
    }
    if ((ascii >= 33 && ascii <= 47) ||
        (ascii >= 58 && ascii <= 64) ||
        (ascii >= 91 && ascii <= 96) ||
        (ascii >= 123 && ascii <= 126)) {
      specCount++;
    }
  }
  list[1].value = upCount > 1;
  list[2].value = lowCount > 1;
  list[3].value = numCount > 1;
  list[4].value = specCount > 1;
  for (int i = 0; i < list.length; i++) {
    if (!list[i].value) {
      return false;
    }
  }
  return true;
}

@riverpod
class AgreementNotifier extends _$AgreementNotifier {
  @override
  List<bool> build() {
    return <bool>[false, false];
  }

  void change(bool val) {
    state = [val, state[1]];
  }

  void changeSubmitCount() {
    state = [state[0], true];
  }
}

@riverpod
class SliderIndexHomeNotifier extends _$SliderIndexHomeNotifier {
  @override
  int build() {
    return 0;
  }

  void setIndex({required int index}) {
    state = index;
  }
}

@riverpod
class Refresh extends _$Refresh {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@riverpod
class Refresh2 extends _$Refresh2 {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@Riverpod(keepAlive: true)
class RangeCtrl extends _$RangeCtrl {
  @override
  RangeValues build() {
    return const RangeValues(0, 6000000);
  }

  void changeValue({double? min, double? max}) {
    if (min != null && max != null) {
      state = RangeValues(min, max);
    } else if (min != null) {
      state = RangeValues(min, state.end);
    } else if (max != null) {
      state = RangeValues(state.start, max);
    }
  }

  void changeRange({required RangeValues rangeValues}) {
    state = rangeValues;
  }
}

// final filterSearch = Provider<FilterModel>((ref) {
//   return FilterModel();
// });
// final apiProvider = Provider<ApiService>((ref) {
//   return ApiService();
// });

// final recentVehicleProvider = FutureProvider<List<VehicleDataModel>>((ref) {
//   return ref.watch(apiProvider).top4Cars();
// });
// FutureProvider<List<VehicleDataModel>> allVehicleProvider =
//     FutureProvider<List<VehicleDataModel>>((ref) {
//   return ref
//       .watch(apiProvider)
//       .getVehicleList(filterModel: ref.watch(filterSearch), pageNo: 1);
// });

// final FutureProvider<List<CarBeadingModel>> beadingCarProvider =
//     FutureProvider<List<CarBeadingModel>>((ref) {
//   return ref.watch(apiProvider).getBeadingCarList();
// });

// FutureProvider<UserInfoModel> getUserInfoProvider({required int userId}) {
//   final temp = FutureProvider<UserInfoModel>((ref) {
//     return ref.watch(apiProvider).getAccountInfo(userId: userId);
//   });
//   return temp;
// }
@riverpod
class LoadingCntr extends _$LoadingCntr {
  @override
  bool build() {
    return false;
  }

  void change({required bool val}) {
    state = val;
  }
}

Future<TokenModel?> isAuth(
    {required BuildContext context, bool toNavigateLogin = true}) async {
  if (await SharedService.isLoggedIn()) {
    String? token = await SharedService.getLoginDetails();
    log("Token:  $token");
    bool hasExpired = JwtDecoder.isExpired(token!);

    if (!hasExpired) {
      log(token);
      return TokenModel.fromJson(JwtDecoder.decode(token), token);
    } else {
      await SharedService.logOut(context: context);
      showSnackBar(
          color: Colors.red,
          message: 'Token expired,please login again..',
          context: context);
      return null;
    }
  } else {
    if (toNavigateLogin) {
      Navigator.of(context).pushNamed('loginScreen');
      showSnackBar(
          color: Colors.redAccent,
          message: "Please login...",
          context: context);
    }

    return null;
  }
}
