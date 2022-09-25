import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us",)),
      body: Column(
        children: [
          Text("My contacts"),
          Text("https://t.me/oxunov1105"),
          Text("My contacts"),
        ],
      ),
    );
  }
}
