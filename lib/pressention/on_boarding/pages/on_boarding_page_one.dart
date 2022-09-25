import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/icons (2).dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 84.h, left: 81.w, right: 52.w),
            child: Image.asset(
              MyIcons.onBoarding1,
              height: 277.78.h,
              width: 213.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130.h),
            child: Text(
              "Manage your tasks",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 32.sp,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 42.h, left: 38.w, right: 38.w),
            child: Text(
              ("You can easily manage all of your daily tasks in DoMe for free"),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.white),

              // style: MyTextStyle.interRegular400.copyWith(fontSize: 16)
            ),
          ),
        ],
      ),
    );
  }
}
