import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/my_repository.dart';
import '../../../../db/cached_category.dart';
import '../../../../db/cached_todo.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles (2).dart';

class ToDosItem extends StatelessWidget {
  const ToDosItem({
    Key? key,
    required this.toDo,
    required this.isDone,
    required this.onTap,
    required this.onDeleted,
  }) : super(key: key);

  final CachedTodo toDo;
  final VoidCallback onTap;
  final bool isDone;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
          color: MyColors.c_363636,
          borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 15,
                child: Text(
                  toDo.todoTitle,
                  style: MyTextStyle.interSemiBold600.copyWith(color: MyColors.white, fontSize: 20.sp),
                ),
              ),
              const Expanded(child: SizedBox()),
              ...List.generate(
                toDo.urgentLevel,
                (index) => Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 24.h,
                ),
              ),
              ...List.generate(
                5 - toDo.urgentLevel,
                (index) => Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 24.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                tr("Description: "),
                style: MyTextStyle.interRegular400.copyWith(color: MyColors.white)
              ),
              Expanded(
                  child: Text(
                toDo.todoDescription,
                style: MyTextStyle.interRegular400.copyWith(fontSize: 14.sp,color: MyColors.white),
              ))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          FutureBuilder(
              future: MyRepository.getSingleCategoryById(id: toDo.categoryId),
              builder: (BuildContext con, AsyncSnapshot<CachedCategory> snapshot) {
                if (snapshot.hasData) {
                  var category = snapshot.data!;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("Category: "),
                        style: MyTextStyle.interRegular400.copyWith(color: MyColors.white),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        category.categoryName,
                        style: MyTextStyle.interRegular400.copyWith(fontSize: 14.sp,color: MyColors.white),
                      ),
                      const Expanded(child: SizedBox()),
                      Icon(
                        IconData(
                          category.iconPath,
                          fontFamily: "MaterialIcons",
                        ),
                        size: 24.h,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("Deadline: "),
                style: MyTextStyle.interRegular400.copyWith(fontSize: 14.sp,color: MyColors.white),
              ),
              Text(
                toDo.dateTime.substring(0, 16),
                style: MyTextStyle.interRegular400.copyWith(fontSize: 14.sp,color: MyColors.white),
              ),
            ],
          ),
          TextButton(
              onPressed: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(tr("Finished"), style: MyTextStyle.interRegular400.copyWith(color: Colors.white)), Checkbox(value: isDone, onChanged: (v) {})],
              )),
          TextButton(
            onPressed: onDeleted,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
