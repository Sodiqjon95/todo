import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/pressention/login/login_screen/widgets/input_continer.dart';
import 'package:todo/utils/colors.dart';
import '../../../data/local_data/storage.dart';
import '../../../utils/icons (2).dart';
import '../../../utils/styles (2).dart';
import '../../../utils/utility_functions.dart';
import '../../on_boarding/on_boarding_screen.dart';
import '../../tabs/tab_box/tab_box.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String savedUsername = '';
  String savedPassword = '';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    getInitials();
    super.initState();
  }

  void getInitials() {
    savedPassword = StorageRepository.getString("password");
    print("savedPasword:$savedPassword");
    savedUsername = StorageRepository.getString("username");
    print("savedUsername:$savedUsername");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: MyColors.white,
                          size: 25.h,
                        ))),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.33.h,
                    bottom: 33.h,
                  ),
                  child: Text(
                    tr("Login"),
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
                  style: TextStyle(fontSize: 14.sp, color: MyColors.white),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  cursorHeight: 16.sp,
                  style: TextStyle(color: MyColors.white, fontSize: 16.sp),
                  controller: passwordController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
                      ),
                      labelText: tr("Enter your password"),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.white),
                      )),
                ),
                SizedBox(
                  height: 69.h,
                ),
                TextButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    if (username.length > 3 && password.length > 6) {
                      if (username == savedUsername && password == savedPassword) {
                        await StorageRepository.putBool("is_logged", true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                          return TabBox();
                        }));
                      } else {
                        UtilityFunctions.getMyToast(
                          message: tr("Login password wrong\nRegister first"),
                        );
                      }
                    } else {
                      UtilityFunctions.getMyToast(message: tr("Login and password wrong !"));
                    }
                  },
                  child: Container(
                      width: 367.w,
                      height: 50.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: MyColors.c_4C4C7C),
                      child: Center(
                          child: Text(
                        tr("Login"),
                        style: MyTextStyle.interSemiBold600,
                      ))),
                ),
                SizedBox(
                  height: 31.h,
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
                  height: 36.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr("Don’t have an account?"), style: MyTextStyle.interRegular400.copyWith(color: MyColors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                            return RegisterScreen();
                          }));
                        },
                        child: Text(
                          tr("Register"),
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
