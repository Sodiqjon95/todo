import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../basket/basket_screen.dart';
import '../done_list/done_list_screen.dart';
import '../profile/profile_screen.dart';
import '../todo_list/todo_list_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    TodoListScreen(),
    DoneListScreen(),
    BasketScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:screens[currentIndex],
      // IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF363636),
        iconSize: 34.h,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.green),
        // "profile": "Profile",
        // "done": "Done",
        // "todos": "Todos",
        // "basket": "Basket",
        items: [
          getItem(icon: Icons.task, labelText: tr("todos")),
          getItem(icon: Icons.done_all, labelText: tr("done")),
          getItem(icon: Icons.shopping_basket, labelText:tr( "basket")),
          getItem(icon: Icons.perm_identity_rounded, labelText: tr("profile")),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //
      //
      // },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(
          icon,
          size: 35.h,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          size: 50.h,
          color: Colors.white,
        ));
  }
}