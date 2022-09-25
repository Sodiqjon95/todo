import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/utility_functions.dart';


class NetworkWidget extends StatelessWidget {
  const NetworkWidget({Key? key, required this.img, required this.title}) : super(key: key);
  final String img;
  final String title;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child:
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: TextButton(
            onPressed: () {
              UtilityFunctions.getMyToast(
                message: tr("In progress"),
              );
            },
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      img,
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.sp,color: MyColors.white),
                    ),
                  ],
                ))),
      ),
    );
  }
}
