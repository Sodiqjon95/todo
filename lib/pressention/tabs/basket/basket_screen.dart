import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/pressention/tabs/basket/widgets/bascet_item.dart';
import 'package:todo/pressention/tabs/basket/widgets/update_screen.dart';
import '../../../data/my_repository.dart';
import '../../../db/cached_category.dart';
import '../../../db/cached_todo.dart';
import '../../../global_widgets/profile_image_appbar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles (2).dart';
import '../../../utils/utility_functions.dart';


class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<CachedTodo> myTodos = [];
  List<CachedCategory> categories = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 2);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.c_121212,
      appBar: AppBar(
        backgroundColor: MyColors.c_121212,
        leading: const ProfileImageAppbar(),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext con) {
                    return AlertDialog(
                      title: Text(tr("Are you sure you want to delete everything?")),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(tr("Cancel"))),
                        TextButton(
                            onPressed: () {
                              MyRepository.clearAllCachedTodos();
                              _init();
                              Navigator.pop(context);
                            },
                            child: Text(tr("Ok"))),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.clear))
        ],
        title: Text(tr("basket"), style: MyTextStyle.interSemiBold600.copyWith(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: ListView(
        children: List.generate(myTodos.length, (index) {
          var toDo = myTodos[index];
          return BasketItem(
              cachedTodo: myTodos[index],
              onDeleteTapped: () {
                          MyRepository.deleteCachedTodById(id: myTodos[index].id!);
                          Navigator.of(context);
                          _init();
                          UtilityFunctions.getMyToast(
                              message: tr("delete"));
              },
              onUpdateTapped: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const UpDateScreen();
                    }));
              });

        }),
      ),
    );
  }
}
