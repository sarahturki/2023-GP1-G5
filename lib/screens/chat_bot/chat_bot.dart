import 'package:flutter/material.dart';
import 'dart:math' as math; // import this

import '../../widgets/custom_appbar.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

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
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
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
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
        appBar: CustomAppBar.getAppBar("المساعدة أمُومي", context),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SentMessage(message: "Hello this is cool"),
              ReceivedMessage(message: "Hi this is awesome chat bubble"),
              SentMessage(message: "How are you"),
              ReceivedMessage(
                  message:
                      "I am great how are you doing. It while when we talked."),
              SentMessage(
                  message:
                      "Now is good day to try something new and work on it. Stick to the plan")
            ],
          ),
        ));
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
        Flexible(
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
        CustomPaint(painter: Triangle(Colors.grey[300]!)),
      ],
    ));

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
                  color: Colors.white, fontFamily: 'Monstserrat', fontSize: 14),
            ),
          ),
        ),
      ],
    ));

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
