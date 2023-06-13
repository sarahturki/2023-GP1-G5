import 'package:ammommyappgp/models/todos_model.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/models/weekly_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> arabicNumber = [
  "١",
  "٢",
  "٣",
  "٤",
  "٥",
  "٦",
  "٧",
  "٨",
  "٩",
  "١٠",
  "١١",
  "١٢",
  "١٣",
  "١٤",
  "١٥",
  "١٦",
  "١٧",
  "١٨",
  "١٩",
  "٢٠",
  "٢١",
  "٢٢",
  "٢٣",
  "٢٤",
  "٢٥",
  "٢٦",
  "٢٧",
  "٢٨",
  "٢٩",
  "٣٠",
  "٣١",
  "٣٢",
  "٣٣",
  "٣٤",
  "٣٥",
  "٣٦",
  "٣٧",
  "٣٨",
  "٣٩",
  "٤٠",
];
void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
                color: Color.fromARGB(255, 226, 87, 154)),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text(" ... جاري التحميل ")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

final List<String> suggestionNameFemale = [
  "رقية",
  "كوثر",
  "سندس",
  "أفنان",
  "آلاء",
  "آية",
  "رحمة",
  "مودة",
  "لينة",
  "ضحى",
  "سجى",
  "ليلى",
  "ميار",
  "جود",
  "تولين",
  "تيا",
  "ميرال",
  "سيرين",
  "خديجة",
  "عائشة",
  "زينب",
  "سلمى",
  "إيمان",
  "بتول",
  "فريدة",
  "جوري",
  "فاطمة",
  "ندى",
  "نور",
  "شيماء",
  "نقاء",
  "ريهام",
  "هلا",
  "هنا",
  "سما",
  "بلقيس",
  "ايلاف",
  "رهف",
  "سارة",
  "ميعاد",
  "نوف",
  "مرام",
  "اميرة",
  "ملكة",
  "أحلام",
  "الجوهرة",
  "يارا",
  "منار",
  "اروى",
];

final List<String> suggestionNameMale = [
  "عبدالعزيز",
  "عبدالرحمن",
  "عبدالملك",
  "عبدالله",
  "عبدالرحيم",
  "سلطان",
  "سلمان",
  "سليمان",
  "سعود",
  "مبارك",
  "محمد",
  "أحمد",
  "بدر",
  "حمد",
  "خالد",
  "أسامة",
  "أنس",
  "يوسف",
  "وليد",
  "فيصل",
  "تميم",
  "إبراهيم",
  "راشد",
  "متعب",
  "عبدالاله",
  "زياد",
  "يزيد",
  "مصعب",
  "جهاد",
  "سامي",
  "سالم",
  "البراء",
  "معاذ",
  "ثامر",
  "فهد",
  "صالح",
  "صلاح",
  "بندر",
  "سيف",
  "مالك",
  "فارس",
  "مروان",
  "عادل",
  "زهير",
  "حاتم",
  "عاصم",
  "عامر",
  "سطام",
  "مشعل",
  "ليث"
];
String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page.";
    case "account-exists-with-different-credential":
      return "Email already used. Go to login page.";
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password ";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled.";
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account.";
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account.";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid.";
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}

List<Todo> hospitalBag = [
  Todo(
    completed: false,
    name: "ملابس الطفل",
    uid: "1",
  ),
  Todo(
    completed: false,
    name: "ملابس الام",
    uid: "2",
  ),
  Todo(
    completed: false,
    name: "الوثائق",
    uid: "3",
  ),
  Todo(
    completed: false,
    name: " الجوال والشاحن",
    uid: "4",
  ),
  Todo(
    completed: false,
    name: "مستلزمات النظافة",
    uid: "5",
  ),
  Todo(
    completed: false,
    name: " كاميرا",
    uid: "6",
  ),
];
bool loginVaildation(String email, String password , ) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("تأكد من ادخال كلا من الايميل وكلمة السر");
    return false;
  } else if (email.isEmpty) {
    showMessage("أدخل الايميل");
    return false;
  } else if (password.isEmpty) {
    showMessage("أدخل كلمة السر");
    return false;
  } else {
    return true;
  }
}

UserModel? userData;

int? remainWeeks, remainDays;


List<WeeklyInfo> weeklyInfo = [];

WeeklyInfo? currentWeeklyInfo;

// List<Map<String,dynamic>> weeklyInfo/
