import 'package:flutter/material.dart';
import 'package:ammommyappgp/core/app_export.dart';

class WelcomeScreen extends StatelessWidget {
  @override




  Widget build(BuildContext context) {


    void openSignInScreen  () {

      Navigator.of(context).pushReplacementNamed('/sign_in_screen');
    }



    void openSignUPScreen  () {

      Navigator.of(context).pushReplacementNamed('/signUp22');
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
 
                     Container(
                          width: double.maxFinite,
                      height: 370,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
'assets/images/img_group56.png' ,                               
                              ),
                              
                              alignment: Alignment.topRight,
                              fit: BoxFit.fitHeight,
                            ),
                            
                          ),
                          child: Container(
                            decoration : BoxDecoration( 
                          image :   DecorationImage(image: AssetImage('assets/images/img_logoremovebgpreview_293x252.png'  ) 
                          
                          ,fit: BoxFit.contain 
                          ) 
                          
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      
                      ////////////////////////////////////////sign in 
                      GestureDetector(
                        onTap: openSignInScreen,
                        child: Container(
                          margin: getMargin(
                            left: 30,
                            top: 92,
                            right: 30,
                            
                          ),
                          decoration: AppDecoration.outlineIndigoA70033.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder28,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: Container(
                                  padding: getPadding(
                                    left: 30,
                                    top: 10,
                                    right: 30,
                                    bottom: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      
                                      image: AssetImage(
                                        ImageConstant.imgGroup20,
                                        
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                     
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                                    
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 6,
                                        ),
                                        child: Text(
                                          "تسجيل الدخول",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtMontserratRegular24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      //////////////////////////////////////sign UP 
                       GestureDetector(
                        onTap: openSignUPScreen,
                        child: Container(
                          margin: getMargin(
                            left: 30,
                            top: 52,
                            right: 30,
                            
                          ),
                          decoration: AppDecoration.outlineIndigoA70033.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder28,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: Container(
                                  padding: getPadding(
                                    left: 30,
                                    top: 10,
                                    right: 30,
                                    bottom: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      
                                      image: AssetImage(
                                        ImageConstant.imgGroup20,
                                        
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                     
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                                    
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 6,
                                        ),
                                        child: Text(
                                          "حساب جديد",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtMontserratRegular24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
