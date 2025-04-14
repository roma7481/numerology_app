import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NumerologyMessenger {
  static void showInfoPopup(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: _buildRichText(content),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildRichText(String content) {
    final textSpans = <TextSpan>[];

    final urlRegExp = RegExp(
      r'((https?:\/\/)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}([^\s]*)?)',
      caseSensitive: false,
    );

    final matches = urlRegExp.allMatches(content);

    int lastMatchEnd = 0;
    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        textSpans.add(TextSpan(
          text: content.substring(lastMatchEnd, match.start),
          style: const TextStyle(fontSize: 18),
        ));
      }

      final url = content.substring(match.start, match.end);
      final displayUrl = url.startsWith("http") ? url : "https://$url";

      textSpans.add(TextSpan(
        text: url,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final uri = Uri.parse(displayUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text after last match
    if (lastMatchEnd < content.length) {
      textSpans.add(TextSpan(
        text: content.substring(lastMatchEnd),
        style: const TextStyle(fontSize: 18),
      ));
    }

    return SelectableText.rich(
      TextSpan(children: textSpans),
    );
  }
}