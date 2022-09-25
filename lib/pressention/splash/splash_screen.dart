import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../data/local_data/storage.dart';
import '../../utils/icons (2).dart';
import '../login/login_screen/login_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../tabs/tab_box/tab_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  bool isInitial = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await StorageRepository.getInstance();
    isLogged = StorageRepository.getBool("is_logged");
    isInitial = StorageRepository.getBool("is_initial");

    await Future.delayed(Duration(milliseconds: 3400));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext con) {
      return isLogged
          ? TabBox()
          : isInitial == true
              ? LoginScreen()
              : OnBoardingScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.asset(MyIcons.lotti_splesh),
          Lottie.asset(MyIcons.lotti_splesh_indicator, height: 50.h, width: 300.w),
        ],
      ),
    );
  }
}
