import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/models/report_model.dart';
import 'package:ammommyappgp/screens/vital_information_edit/vital_information_edit.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import '../../widgets/custom_appbar.dart';

class VitalInformationDetails extends StatefulWidget {
  final ReportModel reportModel;
  const VitalInformationDetails({super.key, required this.reportModel});

  @override
  State<VitalInformationDetails> createState() =>
      _VitalInformationDetailsState();
}

class _VitalInformationDetailsState extends State<VitalInformationDetails> {
  ReportModel? _reportModel;
  @override
  void initState() {
    setState(() {
      _reportModel = widget.reportModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("المعلومات الحيوية ", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Directionality(
                        textDirection: TextDirection.rtl,

            child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
          
              children: [
                const SizedBox(
                  height: 12.0,
                ),
          
                  const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text(" مستوى السكر في الدم :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                    title:
                        "${_reportModel!.bloodsuger} ملليغرام/ديسيلتر"),
                const SizedBox(
                  height: 12.0,
                ),



                        const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text( "مستوى الضغط في الدم :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                  title:
                     "${_reportModel!.bloodpressure}",
                ),
                const SizedBox(
                  height: 12.0,
                ),


                        const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text("  الوزن :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                  title: " ${_reportModel!.weight} كجم",
                ),
                const SizedBox(
                  height: 12.0,
                ),

                        const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text(" مستوى فيتامين دال :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                  title:            "${_reportModel!.vitaminD}  نانو غرام/ مل   ",
          
                ),
                const SizedBox(
                  height: 12.0,
                ),

                        const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text(" مستوى الكالسيوم :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                  title: " ${_reportModel!.calcium}  ملغم/ ديسيلتر",
                ),
                const SizedBox(
                  height: 12.0,
                ),

                        const Directionality(
            textDirection: TextDirection.rtl,
                    child: Text(" مستوى الهيموجلوبين :"  ,  textDirection: TextDirection.rtl , style: TextStyle(
                              
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                              fontWeight: FontWeight.bold,
                            ),),
                  ),
                SingleVitalInfoDetailsWidget(
                  title: " ${_reportModel!.hemoglobin} غرام",
                ),
               
 Center(
   child: SizedBox(
                    width: 250,
                    child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
 
                      children: [
                        const SizedBox(
                          height: 48.0,
                        ),
                        PrimaryButton(
                          onPressed: () async {
                            ReportModel? reportModelNew =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => VitalInformationEdit(
                                  reportModel: _reportModel!,
                                ),
                              ),
                            );
                            if (reportModelNew != null) {
                              setState(() {
                                _reportModel = reportModelNew;
                              });
                            }
                          },
                          title: "تعديل",
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        PrimaryButton(
                          onPressed: () async {
                            await _generatePDF(_reportModel!);
                            // await savePdfReport(_reportModel!);
                          },
                          title: "حفظ بصيغة PDF",
                        ),
                      ],
                    ),
                  ),
 ),


 const SizedBox(
                  height: 12.0,
                ),

              ],
            )
            
            ,

            
          ),

          

          
        ),

        
      ),
    );
  }

  int calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    final age = currentDate.year - birthDate.year;

    // Adjust the age if the birthdate hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      return age - 1;
    }

    return age;
  }

  Future<void> _generatePDF(ReportModel reportModel) async {
    final pdf = pw.Document();
    final arabicFont = await rootBundle.load('assets/fonts/hacenregular.ttf');
    final ttf = pw.Font.ttf(arabicFont.buffer.asByteData());
    final imageLogo = pw.MemoryImage(
        (await rootBundle.load('assets/pdfimage.png')).buffer.asUint8List());
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(children: [
            pw.Align(
              alignment: pw.Alignment.topCenter,
              child: pw.SizedBox(
                height: 150,
                width: 150,
                child: pw.Image(
                  imageLogo,
                ),
              ),
            ),
            pw.Stack(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12),
                  margin: const pw.EdgeInsets.only(top: 10),
                  width: double.infinity, // Adjust the width as needed
                  height: 120, // Adjust the height as needed
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "العمر: ${calculateAge(userData!.age!)}",
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            "الاسم: ${userData!.firstName} ${userData!.lastName}",
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 12.0,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "الايميل: ${userData!.email}",
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            "اسبوع الحمل: $remainWeeks ",
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: const PdfColor.fromInt(0xffE187B0),
                      width: 2.0,
                    ),
                  ),
                ),
                pw.Positioned(
                  top: -5,
                  right: 10,
                  // bottom: 5,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.only(
                        top: 5.0,
                        right: 5.0,
                        bottom: 5.0,
                        left:
                            5.0), // Adjust padding as needed padding as needed
                    color: PdfColors.white,
                    child: pw.Text(
                      "المعلومات الشخصية ",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 24.0,
            ),
            pw.Stack(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12),
                  margin: const pw.EdgeInsets.only(top: 10),
                  width: double.infinity, // Adjust the width as needed
                  height: 250, // Adjust the height as needed
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            "${DateTime.now().year}\\${DateTime.now().month}\\${DateTime.now().day}",
                            textAlign: pw.TextAlign.center,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            "التاريخ:",
                            textAlign: pw.TextAlign.center,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                          
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 24.0,
                      ),
                      pw.SizedBox(
                        width: 300,
                        child: pw.Table(
                          border: pw.TableBorder.all(color: PdfColors.black),
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "النتيجة",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "نوع التحليل",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.bloodsuger,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "سكر الدم",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.bloodpressure,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "ضغط الدم ",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.weight,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "الوزن ",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.vitaminD,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "فيتامين د",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.calcium,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "كالسيوم",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    _reportModel!.hemoglobin,
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 20,
                                  padding: const pw.EdgeInsets.only(top: 3.0),
                                  child: pw.Text(
                                    "هيموجلوبين",
                                    textAlign: pw.TextAlign.center,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: const PdfColor.fromInt(0xffE187B0),
                      width: 2.0,
                    ),
                  ),
                ),
                pw.Positioned(
                  top: -5,
                  right: 10,
                  // bottom: 5,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.only(
                        top: 5.0,
                        right: 5.0,
                        bottom: 5.0,
                        left:
                            5.0), // Adjust padding as needed padding as needed
                    color: PdfColors.white,
                    child: pw.Text(
                      "المعلومات الحيوية ",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 18.0,
            ),
            
          ]);
        },
      ),
    );
    Directory dir = Directory('/storage/emulated/0/Download');
String formattedDate = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} .Time ${DateTime.now().hour}.${DateTime.now().minute}.${DateTime.now().second}";
final filePath = '${dir.path}/VSreport_$formattedDate.pdf';

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    // ignore: use_build_context_synchronously
    openPdfViewer(context, filePath);
    showMessage("تم حفظ التقرير في التنزيلات");
  }

  void openPdfViewer(BuildContext context, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(pdfPath: pdfPath),
      ),
    );
  }
}

class SingleVitalInfoDetailsWidget extends StatelessWidget {
  final String title;
  const SingleVitalInfoDetailsWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFA8BB8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfPath; // The path to your PDF file

  const PDFViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: PDFView(
        filePath: pdfPath,
        onPageChanged: (int? page, int? total) {
          // Page changed callback
        },
      ),
    );
  }
}

class TopRightCutBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // Start at the bottom-left corner
    path.lineTo(size.width, size.height); // Move to the bottom-right corner
    path.lineTo(size.width, 0); // Move to the top-right corner
    path.lineTo(20, 0); // Move to the top-left corner (cut)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
