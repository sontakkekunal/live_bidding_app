import 'package:dealer_caryanam/View/utility.dart';
import 'package:dealer_caryanam/View/winner_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constant/resizing.dart';
import '../Controller/controller.dart';
import '../Model/bottom_model.dart';
import '../Model/token_model.dart';
import 'live_car_binding_screen.dart';
import 'login_screen.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GetStartScreenState();
  }
}

class _GetStartScreenState extends State {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/startImg.jpg'),
              alignment: Alignment.center,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginManager()));
            //Navigator.of(context).pushReplacementNamed('homeScreen');
          },
          child: Container(
            height: 53.0.h(),
            width: 300.0.w(),
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 50.0.h()),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //gradient: getGradient(),
                color: const Color(0xFFffc000)),
            child: const Text(
              'Explore Now',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 19,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginManager extends StatelessWidget {
  const LoginManager({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TokenModel?>(
      future: isAuth(context: context, toNavigateLogin: false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: getLogo(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')));
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isDealer()) {
          return CaryanamBottomSheet(tokenModel: snapshot.data!);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class CaryanamBottomSheet extends StatefulWidget {
  final TokenModel tokenModel;
  const CaryanamBottomSheet({super.key, required this.tokenModel});

  @override
  State<CaryanamBottomSheet> createState() => _CaryanamBottomSheetState();
}

class _CaryanamBottomSheetState extends State<CaryanamBottomSheet> {
  int _selectedIndex = 0;
  late final List<BottomModel> _userList;

  @override
  void initState() {
    super.initState();
    _userList = [
      BottomModel(
          name: 'Live Bidding',
          iconData: Icons.car_repair_outlined,
          screen: LiveCarBindingScreen(token: widget.tokenModel)),
      BottomModel(
          name: 'Winner Car',
          iconData: Icons.car_crash_sharp,
          screen: WinnerVehicleScreen(
            tokenModel: widget.tokenModel,
          )),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: _userList[_selectedIndex].screen,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorShape: CircleBorder(),
            labelTextStyle: WidgetStateProperty.all(Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.grey[500]))),
        child: NavigationBar(
          elevation: 4.0.h(),
          height: 70.0.h(),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: _userList.map((element) {
            return NavigationDestination(
              icon: Icon(element.iconData),
              label: element.name,
            );
          }).toList(),
        ),
      ),
    );
  }
}
