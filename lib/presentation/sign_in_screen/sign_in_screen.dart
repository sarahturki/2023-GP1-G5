import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ammommyappgp/core/app_export.dart';
import 'package:provider/provider.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}






class _SignInScreenState extends State<SignInScreen> {
  

///////////////////////////////// 
 
/////////////////////////controller 
   final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController() ;
final _passwordController = TextEditingController() ;
///////////////////////////////
///
///
///for password icon
bool _obscureText= true ;

/////////////////for sign in 

      bool _isLoading = false;

///////////////////////dispoe authentecation 

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();


  }

  @override
  Widget build(BuildContext context) {




 void opentheforgetpassword  () {

      Navigator.of(context).pushReplacementNamed('/forgot_pass_screen');
    }


 Future openthehomepage() async {


  
  if (_formKey.currentState!.validate()) 
{ setState(() { _isLoading = true; }); 

try { // try 

   UserCredential userCredential =       await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim()) ;
 Navigator.of(context).pushReplacementNamed('/auth'); 
 ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('تم تسجيل دخولك بنجاح'  , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold  ),
  ) ,  backgroundColor: Colors.teal, 
       ),
       );
    }
  
  //catche
   on FirebaseAuthException catch (e) 
        { 
          
          if (e.code =="invalid-email"){

ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور او البريد الإلكتروني  خاطئة '   , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
       ),
       backgroundColor:Color.fromARGB(255, 155, 26, 17) ,
        ) ) ;
        } else{

ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور او البريد الإلكتروني  خاطئة '   , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
       ), backgroundColor: Color.fromARGB(255, 155, 26, 17),
        ) ) ;

          
        }



          
          print(e);
        
        
        
        
         } 
        finally { setState(() { _isLoading = false; }); } }
      
    }

    void openWelcomeScreen  () {

      Navigator.of(context).pushReplacementNamed('/welcome_screen');
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: 
        
        
         SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          
          
          
          ////////////////////////////pink arrow
                      GestureDetector(
                        onTap: openWelcomeScreen,
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
                  
          /////////////////////////////////////////////////////////////////////////////
          //////////////////////////////////
     
                   Container(
                          width: double.maxFinite,
                      height: 360,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
'assets/images/img_group56.png'                              
                              ),
                              
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                            
                          ),
                          child: Row(children: [
                           Container(
                              width: 180,
                              decoration : BoxDecoration( 
                            image :   DecorationImage(image: AssetImage('assets/images/img_logoremovebgpreview_293x252.png' )
                            
                            ,fit: BoxFit.contain 
                            ) 
                              )
                                                  
                            ),

                                                      
                          Text('مرحبًا مجددًا' , style: 
                          TextStyle(color: Colors.white , fontSize: 30, fontWeight: FontWeight.bold ), 
                          textAlign: TextAlign.center, )
,  
                          ]

                          

                          ),

                                                     

                        ),
                    
          
          
          
          
            
                  SizedBox(height: 15.0),
          
                  ///////////////////////////////////////////email 
                
                  ///
                  ////////////////////////////////////
                  SizedBox(height: 16.0),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _emailController,
          textInputAction: TextInputAction.next,
          
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني : ',
                          labelStyle: TextStyle(
          
                            fontWeight: FontWeight.bold ,
                            fontSize: 17, 
                          ),
          
                          floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
              
                        prefixIcon: Icon(Icons.email_outlined),
                       prefixIconColor:  Color.fromARGB(205, 186, 11, 98),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
          
          
                             enabledBorder: UnderlineInputBorder(    
                        
                            borderSide: BorderSide(color:  Color.fromARGB(205, 186, 11, 98)),   
                            ),  
                                    focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                         ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                              return 'الرجاء ادخال البريد الإلكتروني   mcmmc ';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
          
          
            /////////////////////////////////////////
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور :',
            labelStyle: TextStyle(
          
                            fontWeight: FontWeight.bold ,
                            fontSize: 17, 
                          ),
          
                          floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
              
                            enabledBorder: UnderlineInputBorder(    
                        
                            borderSide: BorderSide(color:  Color.fromARGB(205, 186, 11, 98)),   
                            ),  
                                    focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                         ),
                        prefixIcon: Icon(Icons.lock_outline),
                                      prefixIconColor:  Color.fromARGB(205, 186, 11, 98),



suffixIcon: GestureDetector(onTap: () {

setState(() {
  
_obscureText = !_obscureText;

});
 
},

child: Icon(_obscureText ? Icons.visibility   :   Icons.visibility_off) ,
),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    obscureText: _obscureText,
                      validator: (value) {
                       
                    if (value == null || value.isEmpty) {
                              return 'الرجاء ادخال  كلمة المرور ';
                    }
                    return null;
                                },
                              ),
                  ),
          
          
                SizedBox(height: 35.0),
                
          
                 //////////////////////////////////////////////////////
            
          
          
          
          
          
          
          //////////////////////////////////////////forget password
                GestureDetector(
                  onTap: opentheforgetpassword,
                  child: Align(
                    alignment: Alignment.centerRight,
                    
                    
                      child: Text(
                        "هل نسيت كلمة السر؟",
                        textAlign: TextAlign.left,
                        style: TextStyle(color:  Color.fromARGB(205, 186, 11, 98) , 
                        fontSize: 15 , fontWeight: FontWeight.bold)
                      ),
                    
                  ),
                ),
          

SizedBox(height: 40,),

          ////////////////////////////////////////sign in button
              
               
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
                      : Text('تسجيل دخول'),
                  onPressed: _isLoading ? null : openthehomepage,
                
                  
                ),
              
              
            ],
                  ),
                ),
          ),
    ),
  ),
        
        
        
        
        
      
    )) ;
}
}
