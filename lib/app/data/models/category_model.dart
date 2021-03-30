import 'package:flutter/material.dart';

class CategoryModel {
  final String text;
  final String content;
  final String imagePath;
  final dynamic calculation;
  final Widget page;

  CategoryModel({
    this.page,
    this.calculation = 1,
    this.content = '',
    @required this.text,
    @required this.imagePath,
  });
}
