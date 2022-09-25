// import 'package:flutter/material.dart';
// import 'package:my_todo_app/data/local_data/storage.dart';
// import '../login/login_screen/login_screen.dart';
//
// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   int currentPageIndex = 0;
//   String buttonText = "Next";
//   PageController controller = PageController(initialPage: 0);
//   List<Widget> screens = [
//     Container(
//         color: Colors.pink,
//         child: Center(
//           child: Text("page 1"),
//         )),
//     Container(
//         color: Colors.yellow,
//         child: Center(
//           child: Text("page 2"),
//         )),
//     Container(
//         color: Colors.green,
//         child: Center(
//           child: Text("page 3"),
//         )),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Page View"),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(),
//               GestureDetector(
//                   onTap: () async {
//                     await StorageRepository.putBool("is_initial", true);
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (BuildContext c) {
//                           return LoginScreen();
//                         }));
//                   },
//                   child: Text("Skip"))
//             ],
//           ),
//           Expanded(
//               child: PageView(
//                 physics: NeverScrollableScrollPhysics(),
//                 onPageChanged: (pageIndex) {
//                   print(pageIndex);
//                 },
//                 controller: controller,
//                 children: screens,
//               )),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 10,
//                 color: currentPageIndex == 0 ? Colors.blueAccent : Colors.pink,
//                 width: currentPageIndex == 0 ? 20 : 10,
//               ),
//               const SizedBox(width: 5),
//               Container(
//                 height: 10,
//                 color: currentPageIndex == 1 ? Colors.blueAccent : Colors.pink,
//                 width: currentPageIndex == 1 ? 20 : 10,
//               ),
//               const SizedBox(width: 5),
//               Container(
//                 height: 10,
//                 color: currentPageIndex == 2 ? Colors.blueAccent : Colors.pink,
//                 width: currentPageIndex == 2 ? 20 : 10,
//               )
//             ],
//           ),
//           TextButton(
//               onPressed: () async {
//                 if (currentPageIndex < 2) {
//                   setState(() {
//                     currentPageIndex++;
//                     controller.jumpToPage(currentPageIndex);
//                   });
//                 } else {
//                   await StorageRepository.putBool("is_initial", true);
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (BuildContext c) {
//                         return LoginScreen();
//                       }));
//                 }
//                 if (currentPageIndex == 2) {
//                   setState(() {
//                     buttonText = "Let's start";
//                   });
//                 }
//               },
//               child: SizedBox(
//                 height: 55,
//                 child: Center(
//                   child: Text(buttonText),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/pressention/on_boarding/pages/on_boarding_page_one.dart';
import 'package:todo/pressention/on_boarding/pages/on_boarding_page_thre.dart';
import 'package:todo/pressention/on_boarding/pages/on_boarding_page_two.dart';

import '../../data/my_repository.dart';
import '../../utils/colors.dart';
import '../login/login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children:  const [
            OnBoarding1(),
            OnBoarding2(),
            OnBoarding3(),
          ],
        ),
        Container(
          alignment: const Alignment(-0, 0),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: JumpingDotEffect(
              dotHeight: 16.h,
              dotWidth: 16.w,
              jumpScale: .7.sign,
              verticalOffset: 15.w,
            ),
          ),
        ),

        Positioned(
            top: 58.h,
            left: 24.w,
            child: GestureDetector(
              onTap: (){
                return _controller.jumpToPage(2);
              },
                child: Text(tr("SKIP"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.grey)))),
        Positioned(
          top: 702.h,
          left: 201.w,
          child: onLastPage
              ? GestureDetector(
                  onTap: () async{
                    await MyRepository.addInitialValues();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    }));
                  },
                  child: Container(
                    width: 150.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: MyColors.c_8875FF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("Get Started"),
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Container(
                    width: 150.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: MyColors.c_8875FF),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("Next"),
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ]),
    );
  }
}
