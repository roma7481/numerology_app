import 'package:flutter/material.dart';
import 'package:numerology/app/data/language/data_parser_en.dart';

class CategoryModel {
  final String name;
  final String imagePath;
  final String dayContent;
  final CategoryType type;

  CategoryModel({
    @required this.type,
    @required this.name,
    @required this.imagePath,
    this.dayContent,
  });
}
