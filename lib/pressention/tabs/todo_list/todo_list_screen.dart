import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo/pressention/tabs/todo_list/widgets/category_item.dart';
import 'package:todo/pressention/tabs/todo_list/widgets/model_top_view.dart';
import 'package:todo/pressention/tabs/todo_list/widgets/select_date_item.dart';
import 'package:todo/pressention/tabs/todo_list/widgets/selectl_urgent_level.dart';
import 'package:todo/pressention/tabs/todo_list/widgets/todos_item.dart';
import '../../../category_add_screen.dart';
import '../../../data/my_repository.dart';
import '../../../db/cached_category.dart';
import '../../../db/cached_todo.dart';
import '../../../global_widgets/my_cuctom_button.dart';
import '../../../models/cotegory_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons (2).dart';
import '../../../utils/styles (2).dart';
import '../../../utils/utility_functions.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<CachedTodo> myTodos = [];
  List<CachedCategory> categories = [];
  int categorySelectedIndex = -1;
  int urgentLevel = 0;

  //-------------------Data Selecting---------------------

  //Time select
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDescriptionController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }




  _init() async{
      myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 0);
      categories = await MyRepository.getAllCachedCategories();
      setState((){});
  }

  @override
  void dispose() {
    todoTitleController.dispose();
    todoDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.c_121212,
      appBar: AppBar(
        backgroundColor: MyColors.c_121212,
        leading: Container(

          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.file(File(MyRepository.getProfileImageUrl()),fit: BoxFit.cover,),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
              return  CategoryAddScreen(onCategoryAddedListener: (bool value) {
                if(value){
                  _init();
                }
              },);
            }));

          }, child: Center(child: Text(tr("Add category"),style: MyTextStyle.interRegular400.copyWith(color: Colors.white),)),),
          IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return Container(
                          color: MyColors.black,
                          margin: EdgeInsets.all(16.h),
                          child: Scaffold(
                              backgroundColor: MyColors.c_121212,
                              resizeToAvoidBottomInset: false,
                              body: Container(
                                decoration: const BoxDecoration(color: Colors.black),
                                child: Column(
                                  children: [
                                    ModelTopView(
                                        text: tr("Create new todo"),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.h),
                                          child: TextField(
                                            style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                            controller: todoTitleController,
                                            decoration: InputDecoration(
                                                hintText: tr("task name"),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12.r),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                contentPadding: EdgeInsets.all(13.h),
                                                fillColor: const Color(0xFFFFFFFF)
                                                // .withOpacity(0.2),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.h),
                                          child: TextField(
                                            maxLines: 5,
                                            maxLength: 150,
                                            style: TextStyle(fontSize: 19.sp, color: Colors.black),
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                hintText: tr("Description here"),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12.r),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                contentPadding: EdgeInsets.all(13.h),
                                                fillColor: MyColors.white
                                                // .withOpacity(0.8),
                                                ),
                                            controller: todoDescriptionController,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: categories.length,
                                            itemBuilder: (BuildContext context, index) {
                                              return CategoryItem(
                                                isSelected: categorySelectedIndex == index,
                                                categoryModel: categories[index],
                                                onTap: () {
                                                  setState(() {
                                                    categorySelectedIndex = index;
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        SelectUrgentLevel(
                                            selectedStarsCount: 0,
                                            onChanged: (v) {
                                              urgentLevel = v;
                                            }),
                                        SelectDateItem(
                                          text: DateFormat.yMMMd().format(selectedDate),
                                          onTap: () async {
                                            var t = await _selectDate(context);
                                            setState(() {
                                              selectedDate = t;
                                            });
                                          },
                                        ),
                                        SelectDateItem(
                                          text: "${selectedTime.hour}:${selectedTime.minute}",
                                          onTap: () async {
                                            var t = await _selectTime(context);
                                            setState(() {
                                              selectedTime = t;
                                            });
                                          },
                                        ),
                                      ],
                                    )),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyCustomButton(
                                            buttonText: tr("Cancel"),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: MyCustomButton(
                                            buttonText: tr("Save"),
                                            onTap: () async {
                                              String titleText = todoTitleController.text;
                                              String descriptionText = todoDescriptionController.text;
                                              if (titleText.length < 3) {
                                                UtilityFunctions.getMyToast(message: tr("Enter a title"));
                                              } else if (descriptionText.length < 5) {
                                                UtilityFunctions.getMyToast(message: tr("Enter a comment"));
                                              } else if (categorySelectedIndex < 0) {
                                                UtilityFunctions.getMyToast(message: tr("Select Category"));
                                              } else if (urgentLevel == 0) {
                                                UtilityFunctions.getMyToast(message: tr("Choose your importance"));
                                              } else {
                                                var dateTime = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month,
                                                  selectedDate.day,
                                                  selectedTime.hour,
                                                  selectedTime.minute,
                                                );

                                                CachedTodo cachedTodo = CachedTodo(
                                                  dateTime: dateTime.toString(),
                                                  todoTitle: titleText,
                                                  categoryId: categories[categorySelectedIndex].id!,
                                                  urgentLevel: urgentLevel,
                                                  isDone: 0,
                                                  todoDescription: descriptionText,
                                                );
                                                await MyRepository.insertCachedTodo(cachedTodo: cachedTodo);
                                                _init();
                                                setDefaults();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: Text(
          tr("Index"),
    style: MyTextStyle.interSemiBold600.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body:

      myTodos.isEmpty
          ?
      Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(MyIcons.todoScreen)
                ),
                Text(
                  maxLines: 2,
                  tr("What do you want to do today?"),
                  style: MyTextStyle.interRegular400.copyWith(fontSize: 20.sp, color: MyColors.white),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding:EdgeInsets.only(left: 18.w),
                  child: Text(
                    tr("Tap + to add your tasks"),
                    style: MyTextStyle.interRegular400.copyWith(fontSize: 16.sp, color: MyColors.white),
                  ),
                ),
              ],
            )
          : ListView(
              children: List.generate(myTodos.length, (index) {
                var toDo = myTodos[index];
                return ToDosItem(
                    toDo: toDo,
                    isDone: false,
                    onDeleted: (){
                      UtilityFunctions.getMyToast(
                          message: tr("sent to basket"));
                      MyRepository.updateCachedTodoIsDone(isDone: 2, id: myTodos[index].id!);
                      _init();
                    },
                    onTap: () {
                      MyRepository.updateCachedTodoIsDone(id: myTodos[index].id!, isDone: 1);
                      _init();
                      print("$myTodos");
                      // myTodos.removeAt(index);
                    });
              }),
            ),
    );
  }

  void setDefaults() {
    urgentLevel = 0;
    todoDescriptionController.clear();
    todoTitleController.clear();
    categorySelectedIndex = -1;
  }
}

CategoryModel getCategory(List<CategoryModel> categories, int categoryId) {
  return categories.where((element) => element.categoryId == categoryId).toList()[0];
}
