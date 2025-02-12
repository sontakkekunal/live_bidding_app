import 'dart:io';

import 'package:dealer_caryanam/Constant/resizing.dart';
import 'package:dealer_caryanam/Controller/controller.dart';
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:dealer_caryanam/View/get_start_screen.dart';
import 'package:dealer_caryanam/View/live_car_binding_screen.dart';
import 'package:dealer_caryanam/View/login_screen.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:dealer_caryanam/View/winner_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/bottom_model.dart';
import 'View/socket_service.dart';

void main() {
  //getLocalIpAddress();

  runApp(const ProviderScope(child: MainApp()));
}

void getLocalIpAddress() async {
  try {
    // Get the list of network interfaces on the device
    List<NetworkInterface> interfaces = await NetworkInterface.list();

    for (var interface in interfaces) {
      // Filter for the IPv4 address and print the local address
      for (var address in interface.addresses) {
        if (address.type == InternetAddressType.IPv4) {
          print('Local IP Address: ${address.address}');
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color(
              0xFF475f8a,
            ),
            primaryColorLight: const Color(0xFF7884cb)),
        home: const GetStartScreen());
  }
}
