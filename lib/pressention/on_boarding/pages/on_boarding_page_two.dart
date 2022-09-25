import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/icons (2).dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 98.h, left: 52.w, right: 52.w),
            child: Image.asset(
              MyIcons.onBoarding3,
              width: 271.w,
              height: 296.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Text(
              "Orgonaize your tasks",
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 32.sp, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 42.h, left: 38.w, right: 38.w),
            child: Text(
              "You can organize your daily tasks by adding your tasks into separate categories",
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
