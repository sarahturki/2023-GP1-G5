import 'package:ammommyappgp/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const PrimaryButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: double.maxFinite,
        height: 60,
        decoration: AppDecoration.outlineIndigoA70033.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder28,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getFontSize(
                    24,
                  ),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image(
              height: 40,
              image: AssetImage(
                ImageConstant.imgGroup20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
