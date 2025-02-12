import 'package:dealer_caryanam/Model/vehicle_bidding_info_model.dart';
import 'package:dealer_caryanam/Model/vehicle_model.dart';
import 'package:dealer_caryanam/Model/vehicle_winner_model.dart';

class BidsWithVehicleModel {
  final FinalBidsModel finalBidsModel;
  final VehicleModel vehicleModel;
  const BidsWithVehicleModel(
      {required this.vehicleModel, required this.finalBidsModel});
}
