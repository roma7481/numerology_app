import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/models/category_model.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'category_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        return SafeArea(
          child: Scaffold(
            body: _buildContent(context, state.categories),
          ),
        );
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _buildContent(BuildContext context, List<CategoryModel> categories) {
    CategoryModel(imagePath: work, text: 'Work number');

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
