import 'package:ammommyappgp/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:intl/intl.dart'; 
import 'package:jiffy/jiffy.dart';




class PregnancyDueDatePage extends StatefulWidget {
  @override


  
  _PregnancyDueDatePageState createState() => _PregnancyDueDatePageState();
}


      bool _isLoading = false;


class _PregnancyDueDatePageState extends State<PregnancyDueDatePage> {
  
  var selectedDate = new HijriCalendar.now();
  bool _isvisible = false ;
   String newDate  = ""; 
  var dueDate = null ;
  String  formatedDuedate = "" ; 
num numofweeks = 0;


///////////////////////////////////////////////////////////// for sending info 
  Future senddate () async{



    final authInstance = FirebaseAuth.instance;


if (formatedDuedate!= "") {
User? user = authInstance.currentUser;
String userId = user!.uid;
final firestoreInstance = FirebaseFirestore.instance;

firestoreInstance
    .collection('user')
    .doc(userId)
    .update({
      'dueDate': formatedDuedate,
      'lastPeriod': newDate
      , 'numofweeks' : numofweeks 
     
      // add any other user data you want to store
    })
    .then((value) => print('User added'))
    .catchError((error) => print('Failed to add user: $error'));

        Navigator.of(context).pushReplacementNamed('/auth');

}
else {

ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text('الرجاء ادخال التاريخ بشكل صحيح' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ),);


}
    
  }

  ////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {

    
    //HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    return new Scaffold(
     backgroundColor: Colors.white,
      body: new Padding(
        padding: const EdgeInsets.all(1),
        child: new Center(
          child: new Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


          
  
  
                           Container(
  
  
                        height: 350,
  
                            decoration: BoxDecoration(
  
                              image: DecorationImage(
  
                                image: AssetImage(
  
'assets/images/corner.png'       ),
  
                                
  
                                alignment: Alignment.topRight,
  
                                fit: BoxFit.contain,
                                
  
                              ),
  
                            ),
),
  
                          
  

SizedBox( height: 30 , ) ,


          
       Text(  "يرجى ادخال تاريخ بداية اخر دورة شهرية", 
       
       
        textAlign: TextAlign.center,
                                    style: TextStyle( fontSize: 24,
                                    fontWeight: FontWeight.bold  ,
                                    color:  Color.fromARGB(205, 186, 11, 98),
                                ),
)
       
       
          ,
       Text(  "(تاريخ اول يوم من اخر دورة)", 
       
       
        textAlign: TextAlign.center,
                                    style: TextStyle( fontSize: 20,
                                    fontWeight: FontWeight.bold  ,
                                    color:  Color.fromARGB(205, 96, 95, 96),
                                ),
)
    ,
SizedBox(height: 30,)
, 
 Center(
   child: ElevatedButton(
          onPressed: () => _selectDate(context)  ,    
          
          child:  Text('أضغط هنا ',  style: TextStyle ( fontSize: 27 , fontWeight:  FontWeight.bold),) ,
         style: ElevatedButton.styleFrom(
      
          foregroundColor: Colors.white, 
          backgroundColor:Color.fromARGB(255, 232, 103, 174),
                  shadowColor: Color.fromARGB(205, 186, 11, 98),// background
                minimumSize: Size(10, 50), //////// HERE
 
                       elevation: 3,
              
    )
       
        ),
 ),

        
SizedBox( height: 50 , ) ,
          
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                   children: [
                     Container(
                                  padding: new EdgeInsets.all(25.0),

                       child: Center(
                         child: Visibility(
                           child: new Text(
                            'تاريخ اليوم الهجري : \n   ${selectedDate.toString()} هـ',
                                                    textAlign: TextAlign.center,

                            style: TextStyle(
                              fontSize: 20 , 
                       color: Color.fromARGB(205, 87, 12, 49),
                       fontFamily: AppRoutes.welcomeScreen,
                       fontWeight: FontWeight.bold
                            ),
                                         ),
                                       visible: _isvisible,
                     
                     
                                      
                         ),
                     
                     
                     
                     
                       ),
                     ),

                     
                 Container(
                              padding: new EdgeInsets.all(25.0),

                   child: Center(
                    
                     child: Visibility(
                       child: new Text(
                        'الموافق :  \n  $newDate ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20 , 
                   color: Color.fromARGB(205, 87, 12, 49),
                   fontFamily: AppRoutes.welcomeScreen,
                   fontWeight: FontWeight.bold
                   
                        ),
                                     ),
                                   visible: _isvisible,
                 
                 
                                  
                     ),
                 
                 
                 
                 
                   ),
                 ),

                   ],
                 ),

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
                    : Text('ابدأي رحلتك الآن'),
                onPressed: _isLoading ? null : senddate,
              
                
              ),
    


            
            ],
          ),
        ),
      ),
     


    );
  }



  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1450
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
      
      
    );

  
    if (picked != null) {
      setState(() {
        selectedDate = picked;

      });

      
setState(() {
  _isvisible=true ; 
});


      //////////////////////////////////format from  hijri To Gregorian
String h =replaceArabicNumber( selectedDate .toString());

List<String> split = h.split('/'); 
List <int> listinint = split.map(int.parse).toList();
DateTime DateIngregor = selectedDate.hijriToGregorian(listinint.elementAt(0), listinint.elementAt(1), 
listinint.elementAt(2));




////////////////////due date 

setState(() {

  dueDate = new DateTime(DateIngregor.year, DateIngregor.month , DateIngregor.day + 280);
   formatedDuedate = DateFormat('dd/MM/yyy').format(dueDate);
});





DateTime mytime = DateIngregor;
num diffyears = Jiffy(DateTime.now()).diff(mytime, Units.YEAR);

setState(() {
  numofweeks = diffyears ; 
});





///////////////////////
print(dueDate);  

String formattedDate = DateFormat('dd/MM/yyy').format(DateIngregor);





/////////////////////////////last period
setState(() {
  newDate= formattedDate ;
});





    }else if (picked == null) {
      setState(() {
  _isvisible=false ; 
});

setState(() {
  formatedDuedate = ""; 
});



ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text('الرجاء ادخال التاريخ بشكل صحيح' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ),
        );

     
    }




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
    
  


