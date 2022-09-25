import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles (2).dart';

class SelectDateItem extends StatelessWidget {
  const SelectDateItem({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: TextButton(
              onPressed: onTap,
              child: Text(
                text,
                style:
                MyTextStyle.interSemiBold600.copyWith(
                  fontSize: 20.sp,
                  color: MyColors.white,
                ),
              ),
            )));
  }
}