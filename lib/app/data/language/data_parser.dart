import '../models/category_model.dart';

abstract class DataParser {
  const DataParser();

  List<CategoryModel> getCategories();
}
