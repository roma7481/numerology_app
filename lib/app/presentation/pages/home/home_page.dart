import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/language/calc_utils.dart';
import 'package:numerology/app/data/models/category_model.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_pi_charts.dart';

import 'category_tile.dart';
import 'custom_raised_button.dart';
import 'day_category.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) {
          context.read<UserDataCubit>().emitCalcCategoriesUpdate();
        },
        child: _buildPageContent(context));
  }

  Widget _buildPageContent(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            brightness: Brightness.dark,
            title: _buildHeader(),
          ),
          body: _buildContent(
            context,
            state,
          ),
        );
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _buildHeader() {
    return Text(DateService.getFormattedDate(DateTime.now()));
  }

  Widget _buildContent(BuildContext context, UserDataReady state) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            _buildBioCategory(context, state.bio, state.profile),
            _buildDailyCategory(context, state),
            SliverGrid(
              delegate: _buildList(state),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBioCategory(
      BuildContext context, List<double> bio, Profile profile) {
    return SliverToBoxAdapter(
      child: CustomButton(
        child: buildBioPiCharts(
          context,
          bio,
        ),
        onPressed: () async {
          context.read<BioCubit>().emitBioInit(profile);
          await navigateToBioGraphsPage(context);
        },
      ),
    );
  }

  SliverToBoxAdapter _buildDailyCategory(
      BuildContext context, UserDataReady state) {
    var category = state.dayCategory;
    return SliverToBoxAdapter(
      child: buildDayCategory(
        header: category.name,
        content: category.dayContent,
        onPressed: () => CategoryProvider.instance.onCategoryPressed(
            context, state.profile, category.type, category.name),
        imagePath: category.imagePath,
      ),
    );
  }

  SliverChildBuilderDelegate _buildList(UserDataReady state) {
    return SliverChildBuilderDelegate(
      (context, index) {
        var category = state.categories[index];
        return _buildListTile(
          context,
          state.profile,
          category,
        );
      },
      childCount: state.categories.length,
      addAutomaticKeepAlives: false,
    );
  }

  Widget _buildListTile(
    BuildContext context,
    Profile profile,
    CategoryModel category,
  ) {
    return buildCategoryTile(
        context: context,
        text: category.name,
        onPressed: () => CategoryProvider.instance
            .onCategoryPressed(context, profile, category.type, category.name),
        imagePath: category.imagePath);
  }
}
