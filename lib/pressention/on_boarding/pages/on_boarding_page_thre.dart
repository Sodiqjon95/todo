import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/icons (2).dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 75.h, left: 52.w, right: 52.w),
            child: Image.asset(
              MyIcons.onBoarding2,
              height: 277.78.h,
              width: 213.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Text(
              "Create daily routine",
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 32.sp, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 42.h, left: 38.w, right: 38.w),
            child: Text(
              "In Up todo  you can create your personalized routine to stay productive",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
