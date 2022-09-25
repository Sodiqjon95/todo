import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class ModelTopView extends StatelessWidget {
  const ModelTopView({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: MyColors.black,
      child: Column(
        children: [
           SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
               SizedBox(
                width: 60.w,
              ),
              Expanded(
                child: Center(
                  child: Material(
                    color: MyColors.black,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'sf_regular',
                        fontWeight: FontWeight.w600,
                        color: MyColors.white
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: onTap,
                  child:  Text(
                    tr("Close"),
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
