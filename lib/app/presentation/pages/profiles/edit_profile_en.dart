import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/welcome/input_text_tile.dart';

class EditProfileEn extends StatefulWidget {
  final Profile profile;

  const EditProfileEn({Key key, this.profile}) : super(key: key);

  @override
  _EditProfileEnState createState() => _EditProfileEnState();
}

class _EditProfileEnState extends State<EditProfileEn> {
  final controllerProfileName = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerMiddleName = TextEditingController();

  @override
  void dispose() {
    controllerProfileName.dispose();
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerMiddleName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildPageBody(),
      ),
    );
  }

  Widget _buildPageBody() {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildProfileName(),
        ],
      ),
    );
  }

  Widget _buildProfileName() {
    var language = Globals.instance.language;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildHeader(Globals.instance.language.profileName),
          _buildInputField(widget.profile.profileName, controllerProfileName,
              language.profileName),
          _buildHeader(Globals.instance.language.usersName),
          _buildInputField(widget.profile.firstName, controllerFirstName,
              language.firstName),
          _buildInputField(
              widget.profile.lastName, controllerLastName, language.lastName),
          _buildInputField(widget.profile.middleName, controllerMiddleName,
              language.middleName),
        ],
      ),
    );
  }

  Center _buildInputField(
      String text, TextEditingController controller, String hint) {
    if (text != null && text.isNotEmpty) {
      controller.text = text;
    }
    return buildTextInputTile(context, hint, controller);
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        text,
        style: headerTextStyle,
      ),
    );
  }
}
