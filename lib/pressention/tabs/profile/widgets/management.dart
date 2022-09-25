import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/utility_functions.dart';

class ManagementProfile extends StatelessWidget {
  ManagementProfile({Key? key, required this.icon, required this.title,required this.onTap}) : super(key: key);
  final IconData icon;
  final String title;
  VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      height: 48.h,
      width: 340.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.black
      ),
      child: TextButton(
          onPressed: onTap,
          child: Container(
              color: Colors.black,
              child: Row(
                children: [
                  Icon(icon,color: Colors.white,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 10.w),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 16.sp,color: MyColors.white),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
