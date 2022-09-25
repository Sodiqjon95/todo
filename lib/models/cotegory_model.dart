import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel( {
    required this.textStyle,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryId,
    required this.iconPath,
  });

  int categoryId;
  IconData iconPath;
  final String categoryName;
  final Color categoryColor;
  final TextStyle textStyle;
}