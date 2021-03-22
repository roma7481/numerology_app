import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
  );
}
