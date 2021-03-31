import 'package:flutter/material.dart';

class CategoryModel {
  final String text;
  final String content;
  final String imagePath;
  final Widget page;

  CategoryModel({
    this.page,
    this.content = '',
    @required this.text,
    @required this.imagePath,
  });
}
