import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_image_view.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
final user = FirebaseAuth.instance.currentUser!; 


 Future openSignin() async {
   FirebaseAuth.instance.signOut();

       Navigator.of(context).pushReplacementNamed('/welcome_screen'); 
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body:  Center(child:
 Column(
  mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Text(' hello you are here '),
   
   Text(user.email!),


              GestureDetector(
        
                onTap: openSignin,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: getVerticalSize(
                      72,
                    ),
                    width: getHorizontalSize(
                      315,
                    ),
                    margin: getMargin(
                      left: 23,
                      top: 89,
                      bottom: 5,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.img24x21,
                          height: getVerticalSize(
                            24,
                          ),
                          width: getHorizontalSize(
                            21,
                          ),
                          alignment: Alignment.bottomRight,
                          margin: getMargin(
                            right: 23,
                            bottom: 12,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration:
                                AppDecoration.outlineIndigoA70033.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder28,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Expanded(
                  child: SingleChildScrollView( child: Container(
                                  padding: getPadding(
                                    left: 98,
                                    top: 21,
                                    right: 98,
                                    bottom: 21,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ImageConstant.imgGroup20,
                                      ),
                                      fit: BoxFit.cover,
                                    ),

                                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 4,
                                        ),
                                        child: Text(
                                          "تسجيل الخروج",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtMontserratRegular20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ))],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


   


   ],
 )
 
 
 ),


    );
  }
}