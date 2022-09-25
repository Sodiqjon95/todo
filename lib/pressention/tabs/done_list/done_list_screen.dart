import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/my_repository.dart';
import '../../../db/cached_category.dart';
import '../../../db/cached_todo.dart';
import '../../../global_widgets/profile_image_appbar.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles (2).dart';
import '../todo_list/widgets/todos_item.dart';

class DoneListScreen extends StatefulWidget {
  const DoneListScreen({Key? key}) : super(key: key);

  @override
  State<DoneListScreen> createState() => _DoneListScreenState();
}

class _DoneListScreenState extends State<DoneListScreen> {
  List<CachedTodo> myTodos = [];
  List<CachedCategory> categories = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 1);
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        title: Text(
          tr("Done"),
          style: MyTextStyle.interSemiBold600.copyWith(fontSize: 18.sp)
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init();
        },
        child: ListView(
          children: List.generate(myTodos.length, (index) {
            var toDo = myTodos[index];
            return ToDosItem(
              onDeleted: () {
                MyRepository.updateCachedTodoIsDone(isDone: 2, id: myTodos[index].id!);
                _init();
              },
              toDo: toDo,
              isDone: true,
              onTap: () {},
            );
          }),
        ),
      ),
    );
  }
}
