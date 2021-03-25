import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/presentation/pages/home/category_model.dart';

import 'category_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  SafeArea _buildPageContent(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    CategoryModel(imagePath: work, text: 'Work number');

    List<CategoryModel> categories = [];
    categories.add(CategoryModel(imagePath: achievement, text: 'Work number'));
    categories.add(CategoryModel(imagePath: balance, text: 'Work number'));
    categories.add(CategoryModel(imagePath: bioCompatibility, text: 'Work number'));
    categories.add(CategoryModel(imagePath: birthdayCode, text: 'Work number'));
    categories.add(CategoryModel(imagePath: birthdayNum, text: 'Work number'));
    categories.add(CategoryModel(imagePath: challenge, text: 'Work number'));
    categories.add(CategoryModel(imagePath: character, text: 'Work number'));
    categories.add(CategoryModel(imagePath: compatibility, text: 'Work number'));
    categories.add(CategoryModel(imagePath: day, text: 'Work number'));
    categories.add(CategoryModel(imagePath: desire, text: 'Work number'));
    categories.add(CategoryModel(imagePath: expression, text: 'Work number'));
    categories.add(CategoryModel(imagePath: intelligence, text: 'Work number'));
    categories.add(CategoryModel(imagePath: karma, text: 'Work number'));
    categories.add(CategoryModel(imagePath: lifePath, text: 'Work number'));
    categories.add(CategoryModel(imagePath: love, text: 'Work number'));
    categories.add(CategoryModel(imagePath: luckyGem, text: 'Work number'));
    categories.add(CategoryModel(imagePath: lucky, text: 'Work number'));
    categories.add(CategoryModel(imagePath: marriage, text: 'Work number'));
    categories.add(CategoryModel(imagePath: matrix, text: 'Work number'));
    categories.add(CategoryModel(imagePath: matrixLines, text: 'Work number'));
    categories.add(CategoryModel(imagePath: maturity, text: 'Work number'));
    categories.add(CategoryModel(imagePath: money, text: 'Work number'));
    categories.add(CategoryModel(imagePath: month, text: 'Work number'));
    categories.add(CategoryModel(imagePath: name, text: 'Work number'));
    categories.add(CategoryModel(imagePath: personality, text: 'Work number'));
    categories.add(CategoryModel(imagePath: potential, text: 'Work number'));
    categories.add(CategoryModel(imagePath: secondaryBio, text: 'Work number'));
    categories.add(CategoryModel(imagePath: soul, text: 'Work number'));
    categories.add(CategoryModel(imagePath: work, text: 'Work number'));
    categories.add(CategoryModel(imagePath: year, text: 'Work number'));


    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: _buildList(categories),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.8),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverChildBuilderDelegate _buildList(List<CategoryModel> categories) {
    return SliverChildBuilderDelegate(
      (context, index) {
        var category = categories[index];
        return _buildListTile(category.text, category.imagePath);
      },
      childCount: categories.length,
      addAutomaticKeepAlives: false,
    );
  }

  Widget _buildListTile(String text, String iconPath) {
    return buildCategoryTile(text: text, onPressed: () {}, imagePath: iconPath);
  }
}
