import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ammommyappgp/core/app_export.dart';


class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}
final _emailconroller = TextEditingController() ;
   final _formKey = GlobalKey<FormState>();

      bool _isLoading = false;

  void dispose() {
    // TODO: implement dispose
    dispose();
    _emailconroller.dispose();
    


  }

class _ForgotPassScreenState extends State<ForgotPassScreen> {

////////////////////////////fincoin for button 
   Future restpass() async 
   {
  if (_formKey.currentState!.validate()) 
{
    setState(() { _isLoading = true; }); 
try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailconroller.text.trim()).
      then((value) => print('! تم الارسال , تحقق من ايميلك ')) ;
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('! تم الارسال , تحقق من ايميلك '  , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      ) ,  backgroundColor: Colors.teal ,));

        Navigator.of(context).pushReplacementNamed('/sign_in_screen'); }
on FirebaseAuthException catch (e)  {
print('خطأ $e');
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('! فشل الارسال , تحقق من الايميل المدخل ' , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
        ),
        backgroundColor: Color.fromARGB(255, 155, 26, 17),
        ));

}

 finally { setState(() { _isLoading = false; }); }
    }}
///////////////////////////nevegitor for pink arrow
 void backtosigin  () {

      Navigator.of(context).pushReplacementNamed('/sign_in_screen');
    }

  @override

 
  Widget build(BuildContext context) {
    return 


Scaffold(
    
       backgroundColor: const Color.fromRGBO(255, 255, 255, 1) ,
      body: 
      SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


SizedBox(height: 30,),

////////////////////////////pink arrow
                    GestureDetector(
                      onTap: backtosigin,
                      child: CustomImageView(
                        imagePath: ImageConstant.img1,

                        height: getVerticalSize(
                          35,
                        ),
                        width: getHorizontalSize(
                          45,
                        ),
                        
                      alignment: Alignment.topLeft,
                      
                        margin: getMargin(
                          top: 20,
left: 10

                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                

//////////////////////////////////

Container(
                        width: double.maxFinite,
                        height: 350,
                        child: Container(
                          width: double.maxFinite,
                      height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
'assets/images/img_group56.png'                              
                              ),
                              
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                            
                          ),
                          child: Container(
                            decoration : BoxDecoration( 
                          image :   DecorationImage(image: AssetImage('assets/images/img_logoremovebgpreview_293x252.png' )
                          
                          ,fit: BoxFit.contain 
                          ) 
                            )
                          ),
                        ),
                      ),



            SizedBox(height: 50,),


          
       Text(  "لتغيير كلمة المرور الخاصة بك \n  الرجاء ادخال ايميلك الالكتروني ", 
       
       
        textAlign: TextAlign.center,
                                    style: TextStyle( fontSize: 17,
                                    fontWeight: FontWeight.bold  ,
                                    color:  Color.fromARGB(205, 186, 11, 98),
                                ),
)
               
                ///
                ////////////////////////////////////
                ,
            SizedBox(height: 30,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _emailconroller,
                              textInputAction: TextInputAction.next,
enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني : ',
                        labelStyle: TextStyle(

                          fontWeight: FontWeight.bold ,
                          fontSize: 15, 
                        ),

                        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
                                          prefixIconColor:  Color.fromARGB(205, 186, 11, 98),

                      prefixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),


                           enabledBorder: OutlineInputBorder(    
                      
                          borderSide: BorderSide(color:  Color.fromARGB(205, 186, 11, 98)),   
                          ),  
                                  focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                       ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال البريد الإلكتروني   ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),




               //////////////////////////////////////////////////////
            SizedBox(height: 45.0),








////////////////////////////////////////
            
             
               ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 25,
                      ),
              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 232, 103, 174),
              shadowColor: Color.fromARGB(255, 247, 40, 109),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0)),
              minimumSize: Size(7, 60), //////// HERE
            ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('ارسال  '),
                onPressed: _isLoading ? null : restpass,
              
                
              ),
            
            
          ],
        ),
      ),
    ),
      ));





/*



SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.pinkA10002,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 23,
            top: 36,
            right: 23,
            bottom: 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: getPadding(
                      left: 4,
                      right: 80,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: backtosigin,
                          child: CustomImageView(
                            imagePath: ImageConstant.img,
                            height: getVerticalSize(
                              30,
                            ),
                            width: getHorizontalSize(
                              30,
                            ),
                            margin: getMargin(
                              bottom: 18,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SingleChildScrollView(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgLogoremovebgpreview,
                            height: getVerticalSize(
                              180,
                            ),
                            width: getHorizontalSize(
                              176,
                            ),
                            margin: getMargin(
                              left: 38,
                              top: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: getPadding(
                        top: 1,
                      ),
                      child: Text(
                        "للحصول على كلمة سر جديدة",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtMontserratRegular20,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: getPadding(
                      left: 14,
                      top: 18,
                    ),
                    child: Text(
                      "الرجاء إدخال البريد الإلكتروني لإرسال رمز تغيير كلمة السر ",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtMontserratRegular13,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: getPadding(
                        top: 98,
                        right: 10,
                      ),
                      child: Text(
                        ": البريد الالكتروني ",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppStyle.txtABeeZeeRegular14Black900,
                      ),
                    ),
                  ),
                ),
 ///////////////////////////////////////               //////////////////////////////text feild for forget pass 
               
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container( 
            padding: EdgeInsets.all(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),

            child:  TextField(
              controller: _emailconroller,
               style: TextStyle(fontSize:20),
               textAlign: TextAlign.right,
                   textDirection: TextDirection.rtl,
enableSuggestions: true,
autocorrect: true,
            decoration: InputDecoration(
        
            
             hintText:'example@abc.com', 
             hintTextDirection: TextDirection.rtl, hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]) 
             
     , enabledBorder: UnderlineInputBorder(    
                    
                        borderSide: BorderSide(color:  Color.fromRGBO(255, 255, 255, 0.804)),   
                        ),  
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 80, 13, 63)),
                     ),  





              ) ), ),
          )), 
      
      
      
          
          ////////////////////////////sign in button
          
          
                SingleChildScrollView(
                  child: GestureDetector(
                        
                    onTap: restpass ,
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
                                    AppDecoration.signup.copyWith(
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
                
                                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                                        
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: getPadding(
                                              top: 4,
                                            ),
                                            child: Text(
                                              "تسجيل الدخول",
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
                ),
          
          
          
          
          
              ],
            ),
          ),
        ),
      ),
    ); */

  }
}











