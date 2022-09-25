import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles (2).dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isActive,
    required this.flag,
  }) : super(key: key);

  final String text;
  final String flag;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(flag,style: MyTextStyle.interSemiBold600.copyWith(fontSize: 24.sp),),
                SizedBox(width: 18.sp,),
                Text(
                  text,
                  style: MyTextStyle.interSemiBold600.copyWith(fontSize: 20.sp, color: MyColors.white),
                ),
              ],
            ),
            Visibility(
              child: isActive ? const Icon(Icons.check_box,size: 25,color: MyColors.white,) : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
