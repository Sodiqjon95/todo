import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/pressention/tabs/profile/sub_screen/settings_screen.dart';
import 'package:todo/pressention/tabs/profile/widgets/management.dart';

import '../../../data/local_data/storage.dart';
import '../../../data/my_repository.dart';
import '../../../db/cached_todo.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles (2).dart';
import '../../../utils/utility_functions.dart';
import '../../login/register_screen/register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imagePath = "";
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  List<CachedTodo> myTodos = [];
  List<CachedTodo> myDoneTodos = [];
  String username = '';

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    imagePath = StorageRepository.getString("profile_image");
    myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 0);
    myDoneTodos = await MyRepository.getAllCachedTodosByDone(isDone: 1);
    username = StorageRepository.getString("username");
  }

  bool isValidEmail({required String email}) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  getFromGallery() async {
    imageFile = await _picker.pickImage(
      maxHeight: 500.h,
      maxWidth: 500.w,
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      await StorageRepository.putString(
        key: "profile_image",
        value: imageFile!.path,
      );
      setState(() {
        imagePath = imageFile!.path;
      });
    }
  }

  getFromCamera() async {
    imageFile = await _picker.pickImage(
      maxHeight: 500.h,
      maxWidth: 500.w,
      source: ImageSource.camera,
    );
    if (imageFile != null) {
      await StorageRepository.putString(key: "profile_image", value: imageFile!.path);
      setState(() {
        imagePath = imageFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.c_121212,
      appBar: AppBar(
        backgroundColor: MyColors.c_121212,
        title: Text(
          tr("Profile"),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity.w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Profile",style: MyTextStyle.interSemiBold600.copyWith(fontSize: 20),),
              Stack(
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 150.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: imagePath.isEmpty
                          ? Image.asset("assets/images/profile.png")
                          : Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      right: 0.w,
                      bottom: 0.h,
                      child: Center(
                        child: TextButton(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 24.w,
                          ),
                          onPressed: () {
                            selectImageDialog(context);
                          },
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                username,
                style: MyTextStyle.interRegular400.copyWith(color: MyColors.white, fontSize: 30.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 154.w,
                    height: 58.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: Colors.grey),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(tr("Task")),Text("  ${myTodos.length.toString()}"),],
                    ),
                  ),
                  ),
                  Container(
                    width: 154.w,
                    height: 58.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: Colors.grey),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(tr("Done")),Text(" ${myDoneTodos.length.toString()}"),],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 275.w, top: 32.h),
                child: Text(tr("Settings"),
                    style: MyTextStyle.interRegular400.copyWith(
                      color: Colors.white,
                    )),
              ),
              ManagementProfile(
                icon: Icons.settings,
                title: tr("App Settings"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const SettingsScreen();
                      }));
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 275.w, top: 32.h),
                child: Text(tr("Account"),
                    style: MyTextStyle.interRegular400.copyWith(
                      color: Colors.white,
                    )),
              ),
              ManagementProfile(
                icon: Icons.person_rounded,
                title: tr("Change account name"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.vpn_key_outlined,
                title: tr("Change account password"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.photo_camera_outlined,
                title: tr("Change account Image"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 275.w, top: 32.h),
                child: Text(tr("UpTodo"),
                    style: MyTextStyle.interRegular400.copyWith(
                      color: Colors.white,
                    )),
              ),
              ManagementProfile(
                icon: Icons.menu_outlined,
                title: tr("About US"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.info_outline,
                title: tr("FAQ"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.flash_on,
                title: tr("Help & Feedback"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.favorite_border,
                title: tr("Support US"),
                onTap: () {
                  UtilityFunctions.getMyToast(
                    message: tr("In progress"),
                  );
                },
              ),
              ManagementProfile(
                icon: Icons.logout_outlined,
                title: tr("Log out"),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const RegisterScreen();
                      }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImageDialog(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.h),
              height: 150.h, //MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text("Gallery"),
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text("Camera"),
                    onTap: () {
                      getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
