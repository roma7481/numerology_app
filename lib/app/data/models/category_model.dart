import 'package:flutter/material.dart';

class CategoryModel {
  final String text;
  final String imagePath;
  final dynamic calculation;

  CategoryModel({
    this.calculation = 1,
    @required this.text,
    @required this.imagePath,
  });
}
