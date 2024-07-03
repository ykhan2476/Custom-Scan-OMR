import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

//Scanned OMR result pdf 
class PDFservices{
  Future<Uint8List> genpdf(pdf){
    return pdf.save();
  }
  Future<void> savepdffile(String filename,Uint8List bytelist) async{
    final output =await getTemporaryDirectory();
    var filePath ="${output.path}/${filename}.pdf";
    final file =File(filePath);
    await file.writeAsBytes(bytelist);
    await OpenFile.open(filePath);
  }
}


class ScanResult extends StatefulWidget {
  
  final int totalColumns;
  File? image;
  final List<List<dynamic>> AnsKey;
  int totalmcq;
  int totalquestions;
  final String posMarks;
  final String negMarks;
  ScanResult(
      {Key? key,
      required this.posMarks,
      required this.negMarks,
      required this.AnsKey,
      required this.totalmcq,
      required this.image,
      required this.totalquestions,
      required this.totalColumns});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  PDFservices OmrReport = PDFservices();
 
  String? responseData2;
  int correctAnswers=0;
  int wrongAnswers=0;
  String Error='';
  Map<String, dynamic>? responseData;
  String processed_image="";

  @override
  void initState() {
    super.initState();
    sendApiRequest();
  }

  //call omr api  to scan result
    Future<void> sendApiRequest() async {
    try {
      List<int> imageBytes = await widget.image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      final Map<String, dynamic> payload = {
        'nested_list': widget.AnsKey,
        'integer_value': widget.totalmcq,
        'image_bytes': base64Image,
        'Columns':widget.totalColumns
      };
      String apiUrl = 'https://ykhan2476.pythonanywhere.com/ScanOMR';

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseData = jsonDecode(response.body);
        setState(() {
          correctAnswers = responseData?['correct_answers'];
          wrongAnswers = responseData?['wrong_answers'];
          processed_image= responseData?['processed_image'];
        });
      } 
     /* if (response.statusCode == 400) {
        responseData = jsonDecode(response.body);
        setState(() {
          Error = responseData?['error'];
        });
      }*/
      else {
        print('Request failed with status: ${response.statusCode}');
        setState(() {
          Error='Internal Server Error / Problem in Template or Image .';
          responseData = null;
        });
      }
    } catch (error) {
      print('Error sending API request: $error');
      setState(() {
        responseData = null;
      });
    }
  }



//UI Layout
  @override
  Widget build(BuildContext context) {
    int totalmarks=int.parse(widget.posMarks) *(widget.totalquestions);
    int marksobtained =int.parse(widget.posMarks) * correctAnswers - int.parse(widget.negMarks) * wrongAnswers;
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                height: 30,
                child: Text(
                  'Results',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 10),
              (responseData==null || Error.isNotEmpty)?
              Stack(
                children: [
                  Container(
                    height: hght * 0.6,
                    width: wid,
                    child: Image.asset('assets/images/c.jpg'),
                  ),
                  Stack(children: [
                    Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: hght * 0.45,
                      width: wid * 0.7,
                      
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: hght * 0.45,
                      width: wid * 0.7,
                      child: Image.file(widget.image!),
                    ),
                  )
                  ],)
                  
                 ,
                  Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent,
                      highlightColor: const Color.fromARGB(255, 119, 232, 122),
                      direction: ShimmerDirection.ttb,
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: hght * 0.45,
                        width: wid * 0.7,
                        color: Colors.grey[50],
                      ),
                    ),
                  )
                ],
              ) 
              :
              Column(children: [
                Center(child:Container(height: hght * 0.4,width: wid*0.8,child: Image.memory(base64Decode(processed_image),fit: BoxFit.contain,),)),
                Card(elevation: 5,margin: EdgeInsets.only(left: 30,right: 30,bottom: 30),color: Colors.pink[50],child: Column(children: [
                     SizedBox(height:10,),
                     Row(children: [
                      SizedBox(width: wid*0.2,),
                      Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 255, 246, 77))),
                      SizedBox(width:20,),
                      SizedBox(child:Text('Correct Answer') ,),
                     ],),
                     SizedBox(height:10,),
                     Row(children: [
                      SizedBox(width: wid*0.2,),
                      Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: const Color.fromARGB(255, 115, 251, 120))),
                      SizedBox(width:20,),
                      SizedBox(child:Text('Marked Correct') ,),
                     ],),
                     SizedBox(height:10,),
                     Row(children: [
                      SizedBox(width: wid*0.2,),
                      Stack(children: [
                          Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black)),
                          Container(margin: EdgeInsets.all(5),height: 10,width: 10,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red)),    
                      ],),
                      SizedBox(width:20,),
                      SizedBox(child:Text('Marked Wrong') ,),

                     ],),
                     SizedBox(height:10,),
                ],),)
              ],),
              if (Error.isNotEmpty)
             Container(margin: EdgeInsets.all(20),child: Text('Note : ${Error}'),),
              Card(
                elevation: 3,
                color: Colors.white,
                margin: EdgeInsets.all(10),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    /*SizedBox(height: 10),
                    if (responseData != null) Text('${responseData!}'),
                    SizedBox(height: 10),
                    if (responseData2 != null) Text(responseData2!),*/
                    SizedBox(height: 10),
                    
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Total Correct Answers:',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${correctAnswers}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Total Wrong Answers:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${wrongAnswers}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)))
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Total Marks:',style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        SizedBox(height: 20,child: Text('${totalmarks}',style: TextStyle(fontWeight: FontWeight.bold)))
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Marks Obtained:',style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${marksobtained}',style: TextStyle(fontWeight: FontWeight.bold)))
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Positive  Marking :',style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${widget.posMarks}',style: TextStyle(fontWeight: FontWeight.bold)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Negative  Marking :',style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${widget.negMarks}',style: TextStyle(fontWeight: FontWeight.bold)))
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 5),
              
                  Center(child: 
                  ElevatedButton(
                      onPressed: () async {
                       //Image.memory(base64Decode(processed_image)
                       print(processed_image);
                       Uint8List imageBytes2 = base64Decode(processed_image);
                       final pw.Image image2 = pw.Image(pw.MemoryImage(imageBytes2));


                        final img = await rootBundle.load('assets/logo/CSOicon.png');
                        final imageBytes = img.buffer.asUint8List(); 
                        pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
                 
                  Map<String, dynamic> ResultMap =
                     {'correctAnswers':correctAnswers,'wrongAnswers':wrongAnswers,
                      'totalmarks':totalmarks,'marksobtained':marksobtained,
                       'posMarks':widget.posMarks,'negMarks':widget.negMarks};
                  final pdf = pw.Document();
                  pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a4.copyWith(
                      marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                      ,build: (pw.Context context) { 
                        return pw.Center(child:_Report(context, hght, wid,ResultMap ,image1,image2)
                        );},));
                    final data = await OmrReport.genpdf(pdf);
                    OmrReport.savepdffile("Result Report", data);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 0, 22, 100),
                          foregroundColor: Colors.white),
                      child: Text("Generate Report")),) 
            ],
          ),
        ),
      ),
    );
  }



  
pw.Widget _Report(pw.Context content,hght,wid,Map,img,img2){ 
   var Percentage =Map['marksobtained']/Map['totalmarks'];
   Percentage= double.parse((Percentage*100).toStringAsFixed(2));
   var Accuracy= Map['correctAnswers'] /( Map['correctAnswers']+ Map['wrongAnswers']);
   Accuracy= double.parse((Accuracy*100).toStringAsFixed(2));
    return pw.Container(decoration:pw.BoxDecoration(gradient:pw.LinearGradient(colors: [PdfColors.white,PdfColors.pink50,])),child: pw.Column(children: [
     pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 150,width: 180,alignment:pw.Alignment.topLeft,child: img),
      pw.SizedBox( child: pw.Text('Scanned OMR Report',style: pw.TextStyle(fontSize: 30,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),)),
    ]),

    pw.Center(child:
      pw.Container(margin: pw.EdgeInsets.all(10),child:
            pw.Column(children: [
              pw.Container(decoration: pw.BoxDecoration(border:pw.Border.all(width: 5,color: PdfColors.pink),),width: 450,alignment:pw.Alignment.topLeft,child: img2),
              pw.SizedBox(height:20,),
                     pw.Row(children: [
                      pw.SizedBox(width: 80),
                      pw.Container(height: 20,width: 20,decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(10),color: PdfColors.amber)),
                      pw.SizedBox(width:10,),
                      pw.SizedBox(child:pw.Text('Correct Answer') ,),
                     
                      pw.SizedBox(width: 20),
                      pw.Container(height: 20,width: 20,decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(10),color: PdfColors.green)),
                      pw.SizedBox(width:10,),
                      pw.SizedBox(child:pw.Text('Marked Correct') ,),
                    
                      pw.SizedBox(width: 20),
                      pw.Stack(children: [
                          pw.Container(height: 20,width: 20,decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(10),color: PdfColors.black)),
                          pw.Container(margin: pw.EdgeInsets.all(5),height: 10,width: 10,decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(5),color: PdfColors.red)),    
                      ],),
                      pw.SizedBox(width:10,),
                      pw.SizedBox(child:pw.Text('Marked Wrong') ,),

                     ],),
              
              pw.SizedBox(height: 30,),
              pw.Row(children: [
                pw.SizedBox(width: 80),
                pw.SizedBox(width: 220,child:pw.Text('correctAnswers: ${Map['correctAnswers']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(child:pw.Text('wrongAnswers: ${Map['wrongAnswers']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),

              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.SizedBox(width: 80),
                pw.SizedBox(width: 220,child:pw.Text('totalmarks: ${Map['totalmarks']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text('marksobtained: ${Map['marksobtained']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
               
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.SizedBox(width: 80),
                pw.SizedBox(width: 220,child:pw.Text('positive Marking: ${Map['posMarks']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text('negative Marking: ${Map['negMarks']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
               
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.SizedBox(width: 80),
                pw.SizedBox(width: 220,child:pw.Text((Percentage>0)?'Percentage: ${Percentage}%':'Status: Fail',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text((Accuracy>0)? 'Accuracy:${Accuracy}':'Zero',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
               
              ]),
             

            ],) 
            
            ),  )
    
    ]));
    }
}
