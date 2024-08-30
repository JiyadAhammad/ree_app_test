import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/font_style.dart';

class PreviewCountryFlagUi {
  static Widget show(String? flag) {
    log('flad coming jhere $flag');
    if (flag != null && flag != "") {
      return Text(
        '🇮🇳',
        style: AppFontStyle.styleW700(AppColor.primary, 22),
      );
    } else {
      return Text(
        "🇮🇳",
        style: AppFontStyle.styleW700(AppColor.primary, 22),
      );
    }
  }
}
