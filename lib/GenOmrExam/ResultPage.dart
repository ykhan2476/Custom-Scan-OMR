import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResultPage extends StatefulWidget {

  final List<String> details;

  ResultPage({required this.details});

  @override
  _ResultPageState createState() => _ResultPageState();
}
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

class _ResultPageState extends State<ResultPage> {
  
  PDFservices pdfReport = PDFservices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
     final List<String> details=widget.details;
    double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    int totalMarks =int.parse(details[7])*int.parse(details[5]);
    int MarksObtained =int.parse(details[9]);
    var Percentage =MarksObtained/totalMarks;
    var Accuracy =int.parse(details[10])/int.parse(details[7]);



              
    
  
  
   
   
    //double Percentage = double.parse();
    return Scaffold(
      
      body:SingleChildScrollView(child:Column(children: [
        Stack(children: [
            Container(width: wid,height: hght*0.2,child:Image.asset('assets/images/study.jpg',fit: BoxFit.cover,),),
            Column(children: [   
              SizedBox(height: hght*0.05,),        
              Center(child:Container(margin: EdgeInsets.only(top:50,left:120),width: wid*0.7,
               child: const Text('RESULT',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold ),),)),
             
            ],)
        ],),
         
         Container(color:Colors.blue[50],padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(elevation: 3,color: Colors.white,margin: EdgeInsets.all(10),shadowColor: Colors.grey,child:
            Column(children: [
              SizedBox(height: 20,),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.8,child:Text('Name: ${details[0]}',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
              Row(children: [
              Column(children :[
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.5,child:Text('Roll No. : ${details[2]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.5,child:Text('Class: ${details[1]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.5,child:Text('Positive Marks: ${details[5]}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
            ]),
            Column(children :[
              Container(margin: EdgeInsets.only(left: 0),height: wid * 0.1,width: wid*0.33,child:Text('Set: ${details[3]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              Container(margin: EdgeInsets.only(left: 0),height: wid * 0.1,width: wid*0.33,child:Text('Date: ${details[4]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              Container(margin: EdgeInsets.only(left: 0),height: wid * 0.1,width: wid*0.33,child:Text('Negative Marks: ${details[6]}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              
            ])
            ],)
            ],) 
            
            ),
            SizedBox(height: 5,),
            Stack(children: [
            Card(elevation: 3,color: Colors.white,margin: EdgeInsets.all(10),shadowColor: Colors.grey,child: 
            Row(children: [
              Column(children :[
              SizedBox(height: 20,),
              Container(margin: EdgeInsets.only(left: 10),height: 30,width: wid*0.6,child: Text('PERCENTAGE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.6,child:Text('Total Marks: ${totalMarks}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98))),),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.6,child:Text('Marks Obtained: ${MarksObtained}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              //Container(margin: EdgeInsets.only(left: 20),height: wid * 0.1,width: wid*0.4,child:Text('Percentage: ${Percentage*100}%',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),

            ]),
            Column(children: [
              new CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 10.0,
                  percent: (Percentage<0)?0:Percentage,
                  center: (Percentage<0)?Text("FAIL"):Text("${(Percentage*100).toStringAsFixed(2)}%"),
                  progressColor: Colors.green,
                )
            ],)
            ],) 
            ),
            if(isLoading)
            Center(child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),)],),

            SizedBox(height: 5,),
            Card(elevation: 3,color: Colors.white,margin: EdgeInsets.all(10),shadowColor: Colors.grey,child: 
            Row(children: [
              Column(children :[
              SizedBox(height: 20,),
              Container(margin: EdgeInsets.only(left: 10),height: 30,width: wid*0.6,child: Text('ACCURACY',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.6,child:Text('Total Questions: ${details[7]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98))),),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.6,child:Text('Correct Answers: ${details[10]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              Container(margin: EdgeInsets.only(left: 10),height: wid * 0.1,width: wid*0.6,child:Text('\tWrong Answers: ${details[11]}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),
              //Container(margin: EdgeInsets.only(left: 20),height: wid * 0.1,width: wid*0.4,child:Text('\tAccuracy: ${(Accuracy*100).toStringAsFixed(2)}%',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 100, 98, 98)))),

            ]),
            Column(children: [
              new CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 10.0,
                  percent:Accuracy,
                  center: new Text("${(Accuracy*100).toStringAsFixed(2)}%"),
                  progressColor: Colors.blue,
                )
            ],)
            ],) 
            ),
            SizedBox(height: 5,),
            Row(children: [
              SizedBox(width: 45,),

              ElevatedButton(onPressed: () async{
                setState(() {
                                isLoading = true;
                              });
                //ApiService()._saveResultToLocal(resultMap.toMap());
                print(details);
                Map<String, dynamic> ResultMap = {'Name': details[0],'Class': details[1],'Roll_no.':details[2],'Set': details[3],'Date':details[4],'Total_Marks':totalMarks,'MarksObtained':MarksObtained,'Percentage':(Percentage<0)?'Fail':double.parse((Percentage*100).toStringAsFixed(2)),'Accuracy':double.parse((Accuracy*100).toStringAsFixed(2))};
                print(ResultMap);
                
                String Name ='${details[0]}${details[2]}${details[3]}${details[4]}${totalMarks}${MarksObtained}';
                print(Name);
                var box = await Hive.openBox('ResultMap');
                await box.put(Name,ResultMap);
                bool success =true;
                setState(() {
                  isLoading = false;
                  });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Exam data saved successfully' : 'Failed to save exam data'),backgroundColor: success ? Colors.green : Colors.red,),);
              
              
              }, 
                style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white),
                 child: const Text("Save",)),


              SizedBox(width: 20,),



              ElevatedButton(onPressed: () async {
                  final img = await rootBundle.load('assets/logo/CSOicon.png');
                  final imageBytes = img.buffer.asUint8List(); 
                  pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
                 
                  Map<String, dynamic> ResultMap =
                   {'Name': details[0],'Class': details[1],'Roll_no.':details[2],
                   'Set': details[3],'Date':details[4],'Total_Marks':totalMarks,
                   'MarksObtained':MarksObtained,'Percentage':(Percentage<0)?'Fail':double.parse((Percentage*100).toStringAsFixed(2)),'Accuracy':double.parse((Accuracy*100).toStringAsFixed(2))};
                  final pdf = pw.Document();
                  pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a4.copyWith(
                      marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                      ,build: (pw.Context context) { 
                        return pw.Center(child:_Report(context, hght, wid,ResultMap ,image1)
                        );},));
                    final data = await pdfReport.genpdf(pdf);
                    pdfReport.savepdffile("Result Report", data);

              }, 
                 style:ElevatedButton.styleFrom(backgroundColor:Color.fromRGBO(255, 0, 22, 100),foregroundColor: Colors.white),
                 child: Text("Generate Report"))
            ],)
          ],
        ),
      )],),
    ));
    }




pw.Widget _Report(pw.Context content,hght,wid,Map,img){ 
    return pw.Container(decoration: pw.BoxDecoration(gradient:pw.LinearGradient(colors: [PdfColors.white,PdfColors.pink50,])),child: pw.Column(children: [
     pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 150,width: 180,alignment:pw.Alignment.topLeft,child: img),
      pw.SizedBox( child: pw.Text(' Exam Result Report',style: pw.TextStyle(fontSize: 30,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),)),
    ]),

    pw.Center(child:
      pw.Container(margin: pw.EdgeInsets.all(10),child:
            pw.Column(children: [
              pw.SizedBox(height: 20,),
               pw.Center(child:pw.Text('Name: ${Map['Name']}',style: pw.TextStyle(fontSize: 21,fontWeight: pw.FontWeight.bold),)),
            
              pw.SizedBox(height: 30,),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 220,child:pw.Text('Class: ${Map['Class']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(child:pw.Text('Roll number: ${Map['Roll_no.']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),

              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 220,child:pw.Text('Set: ${Map['Set']}',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text('Date: ${Map['Date']}',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),)),
               
              ]),
              pw.SizedBox(height: 40),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 220,child:pw.Text('Total Marks: ${Map['Total_Marks']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text('Marks Obtained: ${Map['MarksObtained']}',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
               
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 220,child:pw.Text('Percentage: ${Map['Percentage']}%',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 200,child:pw.Text('Accuracy: ${Map['Accuracy']}%',style: pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold),)),
               
              ]),
              pw.SizedBox(height: 40),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 120,child:pw.Text('Percentage',style: pw.TextStyle(color: PdfColors.teal,fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.Container(height: 30,width: Map['Percentage']*3,decoration: pw.BoxDecoration(gradient:pw.LinearGradient(colors: [PdfColors.lightBlue100,PdfColors.teal]))),
                pw.SizedBox(width: 20),
                pw.SizedBox(width: 40,child: pw.Text('${Map['Percentage']}%')),
              ]),
               pw.SizedBox(height: 20),
              pw.Row(children: [
                pw.SizedBox(width: 40),
                pw.SizedBox(width: 120,child:pw.Text('Accuracy',style: pw.TextStyle(color: PdfColors.teal,fontSize: 15,fontWeight: pw.FontWeight.bold),)),
                pw.Container(height: 30,width: Map['Accuracy']*3,decoration: pw.BoxDecoration(gradient:pw.LinearGradient(colors: [PdfColors.lightBlue100,PdfColors.teal]))),
                pw.SizedBox(width: 20),
                pw.SizedBox(width: 40,child: pw.Text('${Map['Accuracy']}%')),
              ]),

            ],) 
            
            ),  )
    
    ]));
    }
}


