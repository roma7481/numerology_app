import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

abstract class DataParser {
  const DataParser();

  Future<List<CategoryModel>> getCategories(Profile profile);

  Future<CategoryModel> getPersonalDay(Profile profile);
}
