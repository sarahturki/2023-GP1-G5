import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray400 = fromHex('#b9b9b9');

  static Color pink300C4 = fromHex('#c4d66094');

  static Color pinkA10002 = fromHex('#e874a8');

  static Color blueGray400 = fromHex('#888888');

  static Color gray800 = fromHex('#3a3a3a');

  static Color gray900 = fromHex('#292929');

  static Color pinkA100Ba = fromHex('#baf872af');

  static Color red500 = fromHex('#fd2727');

  static Color pinkA10001 = fromHex('#f872af');

  static Color black9003f = fromHex('#3f000000');

  static Color gray80087 = fromHex('#873a3a3a');

  static Color red50 = fromHex('#ffe9fc');

  static Color black90087 = fromHex('#87000000');

  static Color pinkA100 = fromHex('#f973af');

  static Color black900 = fromHex('#000000');

  static Color indigoA700 = fromHex('#2743fd');

  static Color indigoA70001 = fromHex('#2a46ff');

  static Color indigoA70033 = fromHex('#331b39ff');

  static Color pinkA100A5 = fromHex('#a5ff67d4');

  static Color pink300 = fromHex('#d66095');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
