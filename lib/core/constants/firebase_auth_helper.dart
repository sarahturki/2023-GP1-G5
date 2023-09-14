// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      
 ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('تم تسجيل دخولك بنجاح'  , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold  ),
  ) ,  backgroundColor: Colors.teal, 
       ),
       );

      Navigator.of(context, rootNavigator: true).pop();
      return true;


      
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();



 if (error.code =="invalid-email"){

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


      return false;
    }
  }









///////////////////////////////////////////////////////
///
///
///
///
  Future<bool> signUp(String name, String email, String password,
      BuildContext context, String lastName, DateTime selected) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('user').doc(userCredential.user!.uid).set({
        'name': name,
        'last_name': lastName,
        'email': email,
        'age': selected
      });
      for (var element in hospitalBag) {
        await FirebaseFirestoreHelper.instance.addName(element, "hospitalBag");
      }
ScaffoldMessenger.of(context).showSnackBar( SnackBar
      ( content: Text('تم إنشاء الحساب بنجاح'
      
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      ), 
      
      backgroundColor: Colors.teal
      
      ), );
       
             Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {


      Navigator.of(context, rootNavigator: true).pop();
    if (error.code == 'email-already-in-use') 
      { ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: 
      Text(' .  الحساب موجود بالفعل لهذا البريد الإلكتروني' 
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      ),
     backgroundColor: Color.fromARGB(255, 155, 26, 17) , 
       ), 
        ); }   else if  (error.code =="invalid-email"){

ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('صيغة البريد الإلكتروني  خاطئة '



, 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      ),
      backgroundColor: Color.fromARGB(255, 155, 26, 17),
       ),
        );
        }

        else if (error.code == 'weak-password') { ScaffoldMessenger.of(context).showSnackBar( SnackBar
      ( content: Text('كلمة المرور ضعيفة '
      
      , 
 textAlign: TextAlign.right, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ),
      
      
      
      ), 
      
      backgroundColor: Color.fromARGB(255, 155, 26, 17),
      
      ), ); }
        
        
        
            return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();



  }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
     
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("تم تغيير كلمة السر");
      Navigator.of(context).pop();

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future forgetPassword(String email, BuildContext context) async {
    showLoaderDialog(context);
    await _auth.sendPasswordResetEmail(email: email);
    Navigator.of(context, rootNavigator: true).pop();
  }
}
