import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/pressention/tabs/todo_list/todo_list_screen.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/utils/icons%20(2).dart';
import 'package:todo/utils/styles%20(2).dart';
import 'package:todo/utils/utility_functions.dart';

import 'data/my_repository.dart';
import 'db/cached_category.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({Key? key, required this.onCategoryAddedListener}) : super(key: key);

  final ValueChanged<bool> onCategoryAddedListener;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  List<IconData> icons = [];
  int iconCodePoint = 0;
  int chooseIcon = -1;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    icons.add(
      Icons.add,
    );
    icons.add(
      Icons.abc,
    );
    icons.add(
      Icons.access_alarms,
    );
    icons.add(
      Icons.abc_rounded,
    );
    icons.add(
      Icons.ac_unit_rounded,
    );
    icons.add(
      Icons.sports_basketball,
    );
    icons.add(
      Icons.work,
    );
    icons.add(
      Icons.palette_rounded,
    );
    icons.add(
      Icons.cake_outlined,
    );
    icons.add(
      Icons.speaker_notes,
    );
    icons.add(
      Icons.maps_home_work_outlined,
    );
    icons.add(
      Icons.vape_free,
    );
    icons.add(
      Icons.real_estate_agent_rounded,
    );
    icons.add(
      Icons.handyman,
    );
    icons.add(
      Icons.local_airport_rounded,
    );
    icons.add(
      Icons.code,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.c_121212,
      appBar: AppBar(
        backgroundColor: MyColors.c_121212,
        title: Text("Add category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                cursorHeight: 16.sp,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0.r),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.add),
                  labelText: "Category name",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      icons.length,
                      (index) => GestureDetector(
                          onTap: () {
                            iconCodePoint = icons[index].codePoint;
                            UtilityFunctions.getMyToast(message: "Category is selected");
                          },
                          child: Icon(
                            icons[index],
                            size: 35.h,
                            color: Colors.yellow,
                          ))),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    String categoryName = textController.text;
                    if (categoryName.isEmpty) {
                      UtilityFunctions.getMyToast(
                        message: "Write category name",
                      );
                    } else if (iconCodePoint == 0) {
                      UtilityFunctions.getMyToast(message: "Choose category icon");
                    } else {
                      var categ = CachedCategory(
                        categoryName: categoryName,
                        iconPath: iconCodePoint,
                        categoryColor: Colors.black.value,
                      );
                      var t = await MyRepository.insertCachedCategory(
                        cachedCategory: categ,
                      );
                      if (t.id != null) {
                        UtilityFunctions.getMyToast(message: "Category added successfully");
                        widget.onCategoryAddedListener.call(true);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return const TodoListScreen();
                        }));
                      } else {
                        widget.onCategoryAddedListener.call(false);
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Category",
                          style: MyTextStyle.interSemiBold600.copyWith(color: Colors.white),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Icon(
                          Icons.category,
                          size: 20.h,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  )),
              // SizedBox(height: 100.h,),
              SizedBox(
                child: Lottie.asset(MyIcons.categorias, height: 200),
              ),
              SizedBox(
                child: Lottie.asset(MyIcons.categorias2, height: 300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
