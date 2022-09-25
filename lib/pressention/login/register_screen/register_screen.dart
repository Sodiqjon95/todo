import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/local_data/storage.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons (2).dart';
import '../../../utils/styles (2).dart';
import '../../../utils/utility_functions.dart';
import '../login_screen/login_screen.dart';
import '../login_screen/widgets/input_continer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

    usernameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 25.h,
                        color: MyColors.white,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 14.33.h,
                    bottom: 23.h,
                  ),
                  child: Text(
                    tr("Register"),
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                Text(
                  tr("Username"),
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  cursorHeight: 16.sp,
                  autofocus: false,
                  style: TextStyle(color: MyColors.white, fontSize: 16.sp),
                  onSubmitted: (v) {
                    UtilityFunctions.fieldFocusChange(context, focusNode1, focusNode2);
                  },
                  focusNode: focusNode1,
                  controller: usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
                    ),
                    labelText: tr("Enter your name"),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.white, width: 1.5.w),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  tr("Password"),
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  cursorHeight: 16.sp,
                  autofocus: false,
                  style: TextStyle(color: MyColors.white, fontSize: 16.sp),
                  onSubmitted: (v) {
                    UtilityFunctions.fieldFocusChange(context, focusNode2, focusNode3);
                  },
                  focusNode: focusNode2,
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
                    ),
                    labelText: tr("Enter your password"),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.white, width: 1.5.w),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  tr("Age"),
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  cursorHeight: 16.sp,
                  autofocus: false,
                  style: TextStyle(color: MyColors.white, fontSize: 16.sp),
                  onSubmitted: (v) {
                    focusNode3.unfocus();
                  },
                  focusNode: focusNode3,
                  controller: ageController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
                    ),
                    labelText: tr("Enter your age"),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.white, width: 1.5.w),
                    ),
                  ),
                ),
                SizedBox(
                  height: 39.h,
                ),
                TextButton(
                  onPressed: () async {
                    if (usernameController.text.trim().length > 3 && passwordController.text.trim().length > 6 && ageController.text.isNotEmpty && int.parse(ageController.text) >= 18) {
                      await StorageRepository.putString(key: "username", value: usernameController.text);
                      await StorageRepository.putString(key: "lastname", value: "alijon"); //face
                      await StorageRepository.putString(key: "password", value: passwordController.text);
                      await StorageRepository.putString(key: "age", value: ageController.text);
                      await StorageRepository.putString(key: "user_email", value: "example@gmail.com"); //face
                    }
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    }));
                  },
                  child: Container(
                      width: 367.w,
                      height: 50.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: MyColors.c_4C4C7C),
                      child: Center(
                          child: Text(
                        tr("Register User"),
                        style: MyTextStyle.interRegular400,
                      ))),
                ),
                SizedBox(
                  height: 21.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 144.w,
                      height: 2.h,
                      color: Colors.grey,
                    ),
                    Text(
                      tr("or"),
                      style: TextStyle(fontSize: 16.sp, color: MyColors.white),
                    ),
                    Container(
                      width: 144.w,
                      height: 2.h,
                      color: Colors.grey,
                    ),
                  ],
                ),

                //          google container
                NetworkWidget(img: MyIcons.logoGoogle, title: tr("Login with Google")),

                NetworkWidget(img: MyIcons.apple, title: tr("Login with Apple")),
                SizedBox(
                  height: 26.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr("Already have an account?"), style: MyTextStyle.interRegular400.copyWith(color: MyColors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                            return const LoginScreen();
                          }));
                        },
                        child: Text(
                          tr("Login"),
                          style: MyTextStyle.interRegular400,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
