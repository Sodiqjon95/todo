import 'package:flutter/material.dart';

class UpDateScreen extends StatefulWidget {
  const UpDateScreen({Key? key}) : super(key: key);

  @override
  State<UpDateScreen> createState() => _UpDateScreenState();
}

class _UpDateScreenState extends State<UpDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height:  200,
      color:  Colors.deepPurpleAccent,
    );
  }
}
