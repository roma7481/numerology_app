import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

abstract class DataParser {
  const DataParser();

  List<CategoryModel> getCategories();

  Future<CategoryModel> getPersonalDay(Profile profile);
}
