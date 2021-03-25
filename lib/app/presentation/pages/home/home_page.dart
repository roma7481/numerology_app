import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';

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
    List<Widget> categories = [];
    categories.add(Text('category 1'));
    categories.add(Text('category 2'));
    categories.add(Text('category 3'));
    categories.add(Text('category 4'));

    return Container(
      // color: backgroundColor,
      color: Colors.white,
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

  SliverChildBuilderDelegate _buildList(List<Widget> categories) {
    return SliverChildBuilderDelegate(
      (context, index) {
        Text category = categories[index];
        return _buildListTile(category.data);
      },
      childCount: categories.length,
      addAutomaticKeepAlives: false,
    );
  }

  Widget _buildListTile(String text) {
    return buildCategoryTile(text: text, onPressed: () {});
  }
}
