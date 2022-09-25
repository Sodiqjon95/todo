import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../db/cached_todo.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles (2).dart';

class BasketItem extends StatelessWidget {
  const BasketItem({Key? key, required this.onUpdateTapped, required this.onDeleteTapped, required this.cachedTodo}) : super(key: key);

  final VoidCallback onUpdateTapped;
  final VoidCallback onDeleteTapped;
  final CachedTodo cachedTodo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: MyColors.c_363636,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 15,
                child: Text(
                  cachedTodo.todoTitle,
                  style: MyTextStyle.interSemiBold600.copyWith(color: MyColors.white, fontSize: 20.sp),
                ),
              ),
              const Expanded(child: SizedBox()),
              ...List.generate(
                cachedTodo.urgentLevel,
                    (index) => Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 24.h,
                ),
              ),
              ...List.generate(
                5 - cachedTodo.urgentLevel,
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
                tr("Discription: "),
                style: MyTextStyle.interRegular400.copyWith(color: MyColors.white)
              ),
              Expanded(
                  child: Text(
                    cachedTodo.todoDescription,
                    style: MyTextStyle.interRegular400.copyWith(fontSize: 14.sp,color: MyColors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            TextButton(onPressed: onUpdateTapped, child: Expanded(
              child: Row(children: [
                const Icon(Icons.mode_edit_outline_sharp,color:  Colors.white,),SizedBox(width: 20.w,), Text(tr("Update",),style: MyTextStyle.interRegular400.copyWith(color: MyColors.white),)
              ],),
            )),


            TextButton(onPressed: onDeleteTapped, child:Row(children: [
              const Icon(Icons.delete,color:  Colors.red,),SizedBox(width: 20.w,),Text(tr("Delete"))
            ],),)
          ],)
        ],
      ),
    );
  }
}
