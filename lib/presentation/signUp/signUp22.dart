import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_image_view.dart';




class signUp22 extends StatefulWidget {


  
  @override
  State<signUp22> createState() => _signUp22State();
}


class _signUp22State extends State<signUp22> {





  ///////////////////////
    bool _isButtonPressed = false ; 
 void openWelcomeScreen  () {

      Navigator.of(context).pushReplacementNamed('/welcome_screen');
    } 
/////////////////////////////////////////////passoword check
  bool Passwordconfiermied() {
if (_passwordController.text.trim() == _repeatpasswordconroller.text.trim() ) {
  return true ;
} else {
  return false ;
}
  }
   final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
final TextEditingController _repeatpasswordconroller = TextEditingController();
final TextEditingController _birthController = TextEditingController();




////////////for password icon 
bool _obscureText=  true ;




//////////////////////for pass validotor 
bool ispassword8 = false ; 
bool ispassworhas1num = false ;
bool ispasswordhasCapital = false ; 
bool ispasswordhasSpiical = false ;
bool ispasswordhasSmalLetter = false ;



OnPasswordChange(String password){
final numricregex= RegExp(r'[0-9]');
final capitalregex= RegExp(r'[A-Z]');
final Smallregex= RegExp(r'[a-z]{2}');
final speialregex= RegExp(r'[!@#$%^&*(),.?":{}|<>]');



setState(() {
  ispassword8=false ;
  if (password.length >= 8 )
   ispassword8= true ; 
/////////////////////////
ispassworhas1num =false ;
if (numricregex.hasMatch(password)) 
  ispassworhas1num=true;
/////////////
ispasswordhasCapital=false; 
if (capitalregex.hasMatch(password)) {
  ispasswordhasCapital=true;
}

///////////
ispasswordhasSmalLetter=false;
if (Smallregex.hasMatch(password)) {
  ispasswordhasSmalLetter=true;

}
///////////////
ispasswordhasSpiical=false;
if (speialregex.hasMatch(password)) {
  ispasswordhasSpiical=true; 
}


});


  
}




///////////////for sign up
      bool _isLoading = false;

 void dispose() {
    // TODO: implement dispose
    dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatpasswordconroller.dispose();
    _nameController.dispose();
    _lastnamecontroller.dispose();
    _birthController.dispose();
  }






//////////////
  var selectedDate = new HijriCalendar.now();

   String newDate  = ""; 
  var dueDate = null ;
  String  formatedDuedate = "" ; 
num age = 0;
////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                

//////////////////////////////////

Container(
                        width: double.maxFinite,
                        height: 250,
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











          
                SizedBox(height: 30.0),

                ///////////////////////////////////////////name 
                Focus(
                    onFocusChange:(hasFocus) {
                      
                    }, 
                    child: TextFormField(
                      controller: _nameController,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: true,

                      decoration: InputDecoration(
                        labelText: 'الاسم الأول  :',
                        labelStyle: TextStyle(

                          fontWeight: FontWeight.bold ,
                          fontSize: 15, 
                        ),

                        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
    
                        prefixIcon: Icon(Icons.person_outline),
                                                              prefixIconColor:  Color.fromARGB(205, 186, 11, 98),

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
                          return 'الرجاء ادخال الاسم الأول ';
                        }
                        return null;
                      },
                    ),
                  ),
              
                SizedBox(height: 16.0),

                //////////////////////////////////////////////////
                
                ////////////////////////////////////////laast name 
              TextFormField(
                    controller: _lastnamecontroller,
                    enableSuggestions: true,


                    decoration: InputDecoration(
                      labelText: 'الاسم الأخير :',

                        labelStyle: TextStyle(

                          fontWeight: FontWeight.bold ,
                          fontSize: 15, 
                        ),

                        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
    
                      prefixIcon: Icon(Icons.person_outline),
                                                            prefixIconColor:  Color.fromARGB(205, 186, 11, 98),

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
                            return 'الرجاء ادخال الاسم الأخير ';
                      }
                      return null;
                    },
                  ),
                
                ///
                ///
                ///
                ////////////////////////////////////birthdate 
              
              
                              SizedBox(height: 16.0),
                TextFormField(
                      controller: _birthController,
                enableSuggestions: true,
onTap: () async{


   final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1450
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1380
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
      
      
    );

  
    if (picked != null) {
      setState(() {

                selectedDate = picked;

_birthController.text = selectedDate.toString() ; 
      });



      String h =replaceArabicNumber( selectedDate .toString());

List<String> split = h.split('/'); 
List <int> listinint = split.map(int.parse).toList();
DateTime DateIngregor = selectedDate.hijriToGregorian(listinint.elementAt(0), listinint.elementAt(1), 
listinint.elementAt(2)); 


setState(() {

  dueDate = new DateTime(DateIngregor.year - 1, DateIngregor.month , DateIngregor.day );
   formatedDuedate = DateFormat('dd/MM/yyy').format(dueDate);
});

DateTime mytime = dueDate;

num diffyears = Jiffy(DateTime.now()).diff(mytime, Units.YEAR);


setState(() {
  age = diffyears ; 
});
print(age); 

} else if (picked == null) {



setState(() {
  formatedDuedate = ""; 
  _birthController.text = "" ; 
});



ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text('الرجاء ادخال التاريخ بشكل صحيح' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ),
        );


} ;

},
                      decoration: InputDecoration(
                        labelText: 'تاريخ الميلاد: ',
                          labelStyle: TextStyle(
                
                            fontWeight: FontWeight.bold ,
                            fontSize: 15, 
                          ),
                
                          floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
                                            prefixIconColor:  Color.fromARGB(205, 186, 11, 98),
                
                        prefixIcon: Icon(Icons.calendar_month),
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
                              return 'الرجاء تاريخ الميلاد   ';
                        }
                        return null;
                      },
                    ),
                  
                
            


              
              
              
              
                SizedBox(height: 16.0),
              TextFormField(
                    controller: _emailController,
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
                
                SizedBox(height: 16.0),


          /////////////////////////////////////////
               
                   TextFormField(
                    controller: _passwordController,

                    onChanged: (password) => OnPasswordChange(password),
                              textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      labelText: 'كلمة المرور :',
  labelStyle: TextStyle(

                          fontWeight: FontWeight.bold ,
                          fontSize: 15, 
                        ),

                        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
    
                          enabledBorder: OutlineInputBorder(    
                      
                          borderSide: BorderSide(color:  Color.fromARGB(205, 186, 11, 98)),   
                          ),  
                                  focusedBorder: OutlineInputBorder(
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
                

                              SizedBox(height: 16.0),

///////////////////////////// validator for pass 

   Row(
  
  children: [
  
  AnimatedContainer(
  
    
  
    
  
    
  
    duration: Duration(milliseconds: 500 )
  
    
  
    , width: 20,
  
    height: 20,
  
    decoration: BoxDecoration(
  
  color: ispassword8 ? Colors.green : Colors.transparent,
  
  border: ispassword8?   Border.all( color: Colors.transparent): Border.all( color: Colors.grey.shade400) ,
  
  borderRadius: BorderRadius.circular(50)
  
  
  
    ),
  
    
  
  child: Center(child: Icon(Icons.check  , color: Colors.white ,  size: 15,),),
  
  
  
    ),
  
  
  
  
  
    Text(' طول كلمة السر على الأقل 8 خانات')

  
  ],
  
  
  ),

SizedBox(
  height: 10,
),

 Row(
  
  children: [
  
  AnimatedContainer(
  
      duration: Duration(milliseconds: 500 )
  
    
  
    , width: 20,
  
    height: 20,
  
    decoration: BoxDecoration(
  
  color: ispassworhas1num ? Colors.green : Colors.transparent,
  
  border: ispassworhas1num?   Border.all( color: Colors.transparent): Border.all( color: Colors.grey.shade400) ,
  
  
  borderRadius: BorderRadius.circular(50)
  
  
  
    ),
  
    
  
  child: Center(child: Icon(Icons.check  , color: Colors.white ,  size: 15,),),
  
  
  
    ),
  
  
    Text(' تحتوي كلمة السر على الأقل رقم واحد  ')
  
  
  
  
  
  ],
  
   
  ),



SizedBox(
  height: 10,
), 

  Row(
  
  children: [
  
  AnimatedContainer(
  
    
  
    
  
    
  
    duration: Duration(milliseconds: 500 )
  
    
  
    , width: 20,
  
    height: 20,
  
    decoration: BoxDecoration(
  
  color: ispasswordhasCapital ? Colors.green : Colors.transparent,
  
  border: ispasswordhasCapital?   Border.all( color: Colors.transparent): Border.all( color: Colors.grey.shade400) ,
  
  borderRadius: BorderRadius.circular(50)
  
  
  
    ),
  
    
  
  child: Center(child: Icon(Icons.check  , color: Colors.white ,  size: 15,),),
  
  
  
    ),
  
  
  
  
  
    Text(' تحتوي كلمة السر على الأقل حرف واحد كبير')

  
  ],
  
  
  ),


SizedBox(
  height: 10,
)
,

  Row(
  
  children: [
  
  AnimatedContainer(
  
    
  
    
  
    
  
    duration: Duration(milliseconds: 500 )
  
    
  
    , width: 20,
  
    height: 20,
  
    decoration: BoxDecoration(
  
  color: ispasswordhasSmalLetter ? Colors.green : Colors.transparent,
  
  border: ispasswordhasSmalLetter?   Border.all( color: Colors.transparent): Border.all( color: Colors.grey.shade400) ,
  
  borderRadius: BorderRadius.circular(50)
  
  
  
    ),
  
    
  
  child: Center(child: Icon(Icons.check  , color: Colors.white ,  size: 15,),),
  
  
  
    ),
  
  
  
  
  
    Text(' تحتوي كلمة السر على الأقل 2 أحرف صغيرة')

  
  ],
  
  
  ),

SizedBox(
  height: 10,
)



,   Row(
  
  children: [
  
  AnimatedContainer(
  
    
  
    
  
    
  
    duration: Duration(milliseconds: 500 )
  
    
  
    , width: 20,
  
    height: 20,
  
    decoration: BoxDecoration(
  
  color: ispasswordhasSpiical ? Colors.green : Colors.transparent,
  
  border: ispasswordhasSpiical?   Border.all( color: Colors.transparent): Border.all( color: Colors.grey.shade400) ,
  
  borderRadius: BorderRadius.circular(50)
  
  
  
    ),
  
    
  
  child: Center(child: Icon(Icons.check  , color: Colors.white ,  size: 15,),),
  
  
  
    ),
  
  
  
  
  
    Text('  تحتوي كلمة السر على الأقل رمز واحد مميز مثل: @,. ')

  
  ],
  
  
  ),


SizedBox(
  height: 10,
),











TextFormField(
                    controller: _repeatpasswordconroller,
          textInputAction: TextInputAction.done,

                    obscureText: _obscureText,

                    decoration: InputDecoration(
                      labelText: ' إعادة كلمة المرور :',
                        labelStyle: TextStyle(

                          fontWeight: FontWeight.bold ,
                          fontSize: 15, 
                        ),

                        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 80, 13, 63)),
    
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
                          enabledBorder: OutlineInputBorder(    
                      
                          borderSide: BorderSide(color:  Color.fromARGB(205, 186, 11, 98)),   
                          ),  
                                  focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                       ),
                       
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال  إعادة كلمة المرور ';
                      }
                      return null;
                    },
                  ),
                





               //////////////////////////////////////////////////////
            SizedBox(height: 35.0),


             
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
                    : Text('إنشاء حساب'),
                onPressed: _isLoading ? null : _signup,
              
                
              ),
            SizedBox(height: 16,)
            
          ],
        ),
      ),
    ),
  ),
);


}



Future<void> _signup() async { 
  
  
    if (_formKey.currentState!.validate()) 
{ setState(() { _isLoading = true; });  

if (formatedDuedate!= "") {


if (ispassword8){
  if(ispasswordhasCapital){

    if (ispasswordhasSmalLetter) {
      if (ispasswordhasSpiical) {
        
      if (ispassworhas1num) {
      
      
    
if (Passwordconfiermied()){
  


try { // try 


   UserCredential userCredential = await FirebaseAuth.instance 
    .createUserWithEmailAndPassword( email: _emailController.text.trim(), password: _passwordController.text.trim()); 
   await FirebaseFirestore.instance .collection('user') .doc(userCredential.user!.uid) 
   .set({ 'name': _nameController.text.trim(),'last_name': _lastnamecontroller.text.trim(), 
   
    'email': _emailController.text.trim(),
    'age': age
    });
  
  //catch 
  
           Navigator.of(context).pushReplacementNamed('/PregnancyDueDatePage'); 
 ScaffoldMessenger.of(context).showSnackBar( SnackBar
      ( content: Text('تم إنشاء الحساب بنجاح'
      
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      ), 
      
      backgroundColor: Colors.teal
      
      ), );

      

  }    on FirebaseAuthException catch (e){ 
      if (e.code == 'weak-password') { ScaffoldMessenger.of(context).showSnackBar( SnackBar
      ( content: Text('كلمة المرور ضعيفة '
      
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      
      ), 
      
      backgroundColor: Color.fromARGB(255, 155, 26, 17),
      
      ), ); } else if (e.code == 'email-already-in-use') 
      { ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text(' .  الحساب موجود بالفعل لهذا البريد الإلكتروني' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ),
        ); } 
        else if (e.code =="invalid-email"){

ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('صيغة البريد الإلكتروني  خاطئة '



, 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      ),
      backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );
        }
        
        
        } catch (e) 
        { 
          
     
if (_formKey.currentState!.validate() == true){ 
if (formatedDuedate!= "") {
ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text('الرجاء ادخال التاريخ بشكل صحيح' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ),
        );


}
     else   if(ispassword8==false){

    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور ضعيفة الرجاء اعادة ادخالها'
    
    
    , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
    ),

    backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );

         } else
if(ispasswordhasCapital ==false){


   ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور ضعيفة الرجاء اعادة ادخالها'
    
    
    , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
    ),

    backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );



}
else

if(ispasswordhasSmalLetter ==false){


   ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور ضعيفة الرجاء اعادة ادخالها'
    
    
    , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
    ),

    backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );



}
else
if(ispasswordhasSpiical ==false){


   ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور ضعيفة الرجاء اعادة ادخالها'
    
    
    , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
    ),

    backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );



}

else 
if(ispassworhas1num ==false){


   ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('كلمة المرور ضعيفة الرجاء اعادة ادخالها'
    
    
    , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
    ),

    backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );



}


         
               else 
               if (Passwordconfiermied() == false){
           ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
           Text('كلمة المرور غير متطابقة الرجاء اعادة ادخالها'
           
           , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
           
           ),
           backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        ); } 
         
         
         }

  
          
          print(e);
        
         } 
        finally { setState(() { _isLoading = false; }); } }
        
         }
         ////////////
         }}}}} }




         
         
}

         
         


          String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    
    
    return input;
  }
         }
        
