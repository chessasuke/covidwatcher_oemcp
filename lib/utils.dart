import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class Utils {
  static Future<void> launchURL(String url) async {
    print('url: $url');
    try {
      await launch(url);
    } catch (e) {
      await Clipboard.setData(const ClipboardData(text: visitorReportEmail));
      print('couldnt launch url');
    }
  }

  static Future<void> launchEmailSubmission(
      String email, String subject, String body) async {
    final Uri params = Uri(scheme: 'mailto', path: email, queryParameters: {
      'subject': subject,
      'body': body,
    });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
