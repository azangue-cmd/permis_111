import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CommonFunction {
  static blankSpace(double? height, double? width) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  static divider() {
    return Divider(
      thickness: 3,
      height: 0,
      color: greyShade3,
    );
  }
}
