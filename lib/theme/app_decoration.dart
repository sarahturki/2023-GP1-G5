import 'package:flutter/material.dart';
import 'package:ammommyappgp/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack9003f => const BoxDecoration();
  static BoxDecoration get outlineIndigoA70033 => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(
            -0.04,
            -0.83,
          ),
          end: const Alignment(
            0.8,
            1.68,
          ),
          colors: [
            ColorConstant.pinkA100Ba,
            ColorConstant.red50,
          ],
        ),
      );
  static BoxDecoration get signup => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 244, 208, 228),
            Color.fromARGB(255, 226, 87, 154)
          ],
        ),
      );

  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get fillPinkA10002 => BoxDecoration(
        color: ColorConstant.pinkA10002,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder28 = BorderRadius.circular(
    getHorizontalSize(
      28,
    ),
  );

  static BorderRadius roundedBorder9 = BorderRadius.circular(
    getHorizontalSize(
      9,
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
