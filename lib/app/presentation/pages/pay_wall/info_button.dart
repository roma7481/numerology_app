import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'numerology_messanger.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDeviceRegion(),
      builder: (context, regionSnapshot) {
        if (!regionSnapshot.hasData || regionSnapshot.data != 'RU') {
          return const SizedBox.shrink();
        }

        return FutureBuilder<String?>(
          future: getDialogText('ru', 'dialog_title'),
          builder: (context, dialogSnapshot) {
            String buttonText = dialogSnapshot.data ?? "";

            return Padding(
              padding: const EdgeInsets.only(left: 84.0, right: 84.0, bottom: 24.0),
              child: GestureDetector(
                onTap: () async {
                  String? dialogContent = await getDialogText('ru', 'dialog_text_ios');
                  String? dialogHeader = await getDialogText('ru', 'dialog_title');
                  if (context.mounted) {
                    if (dialogContent != null && dialogContent.isNotEmpty) {
                      NumerologyMessenger.showInfoPopup(
                        dialogHeader ?? "",
                        dialogContent,
                        context,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to fetch information.")),
                      );
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 100,
                    maxWidth: 240,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xffFFA800), Color(0xffFF4D00)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: Color(0xffFFB800), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


Future<String> getDeviceRegion() async {
  const MethodChannel _channel = MethodChannel('getRegionCode');
  try {
    final String region = await _channel.invokeMethod('get');
    return region;
  } catch (e) {
    return 'US'; // fallback
  }
}

Future<String?> getDialogText(String locale, String field) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
        .doc('$locale/russ_info')
        .get();

    if (doc.exists && doc.data() != null) {
      return doc.data()![field] ?? '';
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
