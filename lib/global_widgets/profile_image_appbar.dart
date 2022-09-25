import 'package:flutter/material.dart';
import 'dart:io';
import '../data/my_repository.dart';


class ProfileImageAppbar extends StatelessWidget {
  const ProfileImageAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: MyRepository.getProfileImageUrl().isNotEmpty
            ? Image.file(
          File(MyRepository.getProfileImageUrl()),
          fit: BoxFit.cover,
        )
            : Image.asset("assets/images/default_person.jpg"),
      ),
    );
  }
}