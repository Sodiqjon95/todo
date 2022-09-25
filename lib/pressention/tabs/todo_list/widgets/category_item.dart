import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../db/cached_category.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles (2).dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.categoryModel,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  final CachedCategory categoryModel;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 85.w,
              margin:  EdgeInsets.all(5.h),
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color(categoryModel.categoryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    IconData(categoryModel.iconPath,fontFamily: "MaterialIcons"),
                    size: 35.h,
                    color: Colors.blue,
                  ),
                  Expanded(
                    child: Text(
                      categoryModel.categoryName,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyle.interMedium500
                          .copyWith(fontSize: 16.sp, color: MyColors.white),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Positioned(
                  right: 0.w,
                  left: 0.w,
                  bottom: 0.h,
                  top: 0.h,
                  child: Container(
                    color: MyColors.white.withOpacity(0.3),
                    child: Center(
                      child: Icon(
                        Icons.check_circle_sharp,
                        color: Colors.green,
                        size: 50.sp,

                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}
