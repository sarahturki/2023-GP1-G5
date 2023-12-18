import 'dart:convert';
import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import '../../widgets/custom_appbar.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _sendInitialMessage();
  }

  Future<void> _sendInitialMessage() async {
    await Future.delayed(const Duration(seconds: 2));

    const initialMessage = 'مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟';
    setState(() {
      messages.add(initialMessage);
    });

    const ReceivedMessage(
      message: initialMessage,
    );
    setState(() {
      messages.remove("Loading...");
    });

    return;
  }

  final List<String> exitStatements = [
    "تشاو",
    "وداعا",
    "مع السلامه",
    "باي",
    "الى اللقاء",
    "خلاص",
    "مع السلامة"
  ];

  final Map<String, String> fixedResponses = {
    "مع السلامه": "مع السلامه",
        "ماهو امومي": "أمومي هو تطبيق يساعدك في مرحلة الحمل",
        "ماهو أمومي": "أمومي هو تطبيق يساعدك في مرحلة الحمل",
        "ايش أمومي": "أمومي هو تطبيق يساعدك في مرحلة الحمل",
        "ماهو تطبيق أمومي": "أمومي هو تطبيق يساعدك في مرحلة الحمل",
        "ما معنى أمومي": "أمومي يرمز للامومه",     
           "ما معنى امومي": "أمومي يرمز للامومه",

        "ايش امومي": "أمومي هو تطبيق يساعدك في مرحلة الحمل",

    "السلام عليكم": "وعليكم السلام، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "شكرا": "على الرحب والسعة",
    "مرحبا": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "كيف حالك": "أنا بخير، شكرا على السؤال. كيف يمكنني مساعدتك؟",
    "اهلا": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "شلونك": "أنا بخير، شكرا على السؤال. كيف يمكنني مساعدتك؟",
    "من انت": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "انت مين": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "مين انت": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
    "انت من": "مرحبا، أنا المساعدة أمُومي. كيف يمكنني مساعدتك؟",
  };

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add("Loading...");
    });
    const String apiUrl =
        "https://api-inference.huggingface.co/models/sarahtturkii/aragpt2";

    final Map<String, String> headers = {
      'Authorization': 'Bearer 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',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'inputs': message,
    };

    if (messages.last.contains("Loading...")) {
      const TypingIndicator();
      await Future.delayed(const Duration(seconds: 3));
    }
    if (exitStatements.contains(message.trim())) {
      messages.add(
          "شكراً لك على الدردشة معي اليوم. لقد استمتعت بالتحدث معك\nأتمنى لك يومًا سعيدًا");

      setState(() {
        messages.remove("Loading...");
      });

      return;
    }

    if (fixedResponses.containsKey(message.trim())) {
      // Message is a fixed response, handle it accordingly
      setState(() {
        messages.add(fixedResponses[message.trim()]!);
        messages.remove("Loading...");
      });
      return;
    }

    http.Response response;
    do {
      response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 503) {
        await Future.delayed(const Duration(seconds: 5));
        
      }
    } while (response.statusCode != 200);

    String responseData = utf8.decode(response.bodyBytes);
    dynamic decodedData = json.decode(responseData);
    String finalResponse = processResponse(decodedData[0]['generated_text']);

    if (decodedData is List) {
      if (decodedData.isNotEmpty) {
        setState(() {
          messages.add(finalResponse);

          if (exitStatements.contains(messages.last.trim())) {
            messages.add(
                "شكراً لك على الدردشة معي اليوم. لقد استمتعت بالتحدث معك\nأتمنى لك يومًا سعيدًا");
            return;
          }
        });
      }

      setState(() {
        messages.remove("Loading...");
      });
    } else if (decodedData is Map<String, dynamic>) {
      setState(() {
        messages.add(finalResponse);

        messages.add(
            "شكراً لك على الدردشة معي اليوم. لقد استمتعت بالتحدث معك\nأتمنى لك يومًا سعيدًا");
      });

      setState(() {
        messages.remove("Loading...");
      });

      return;
    }
    setState(() {
      messages.remove("Loading...");
    });
    int index = messages.indexOf(messages.last);

    DocumentReference chatbotHistoryReference = FirebaseFirestore.instance
        .collection("chatbot_history")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .doc();
    await chatbotHistoryReference.set({
      "docId": chatbotHistoryReference.id,
      "Question": messages[index - 1],
      "Answer": messages[index],
    });
  }

  String processResponse(String response) {
    int indexOfAnswer = response.indexOf("answer:");
    String answerPart = "";
    String processedResponse = "";

    List<String> arabicMonths = [
      'الشهر الأولى',
      'الشهر الاول',
      'الشهر الثاني',
      'الشهر الثالث',
      'الشهر الرابع',
      'الشهر الخامس',
      'الشهر السادس',
      'الشهر السابع',
      'الشهر الثامن',
      'الشهر التاسع',
      'الشهر الأول'
    ];

    if (indexOfAnswer != -1) {
      answerPart = response.substring(indexOfAnswer + "answer:".length + 1);

      for (String month in arabicMonths) {
        answerPart = answerPart.replaceAll(month, 'هذا الشهر');
      }

      return answerPart;
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      String message = _textEditingController.text;
                      if (message.isNotEmpty) {
                        _sendMessage(message);
                        _textEditingController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_circle_up,
                      color: Color(0xffE187B0),
                    ),
                  ),
                  filled: true,
                  hintText: "رسالة هنا...",
                  fillColor: const Color(0xffE8E8E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
      appBar: CustomAppBar.getAppBar("المساعدة أُمومي", context),
      body: SingleChildScrollView(
        child: Column(
          children: messages.map((msg) {
            if (msg.startsWith("User: ")) {
              return SentMessage(message: msg.substring(6));
            } else {
              return msg.contains("Loading...")
                  ? const TypingIndicator()
                  : ReceivedMessage(message: msg);
            }
          }).toList(),
        ),
      ),
    );
  }

  void _sendMessage(String message) {
    setState(() {
      messages.add("User: $message");
    });

    sendMessage(message);
  }
}

class SentMessage extends StatelessWidget {
  final String message;
  const SentMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
          CustomPaint(painter: Triangle(Colors.grey[300]!)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}

class Triangle extends CustomPainter {
  final Color bgColor;

  Triangle(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ReceivedMessage extends StatelessWidget {
  final String message;
  const ReceivedMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: Triangle(const Color(0xffE187B0)),
            ),
          ),
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Color(0xffE187B0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Monstserrat',
                      fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: Triangle(const Color(0xffE187B0)),
            ),
          ),
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  width: 120,
                  height: 60,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Color(0xffE187B0),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: const Center(
                    child: SpinKitThreeBounce(
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 40,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}

