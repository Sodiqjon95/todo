import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/styles (2).dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {Key? key, required this.buttonText, required this.onTap})
      : super(key: key);

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Container(
          margin: EdgeInsets.all(8.h),
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: MyTextStyle.interSemiBold600.copyWith(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ),
        ));
  }
}
