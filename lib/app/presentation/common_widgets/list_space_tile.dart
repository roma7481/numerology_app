import 'package:flutter/material.dart';

Widget buildSpaceBox(BuildContext context) {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
    ),
  );
}
