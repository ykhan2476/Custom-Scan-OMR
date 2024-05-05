import 'dart:io';
import 'dart:math';
//import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omr_reader/CreateOmrPdf/omrSheetUI.dart';
import 'package:omr_reader/CreateOmrPdf/omrHeaderIUI.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



class CreateOmrPdf extends StatefulWidget {
  

  const CreateOmrPdf({super.key});
  

  @override
  State<CreateOmrPdf> createState() => _CreateOmrPdfState();
}

class _CreateOmrPdfState extends State<CreateOmrPdf> {
  int totalSections = 1;
  List<int> questionsInSection = [0];
  List<TextEditingController> questionsInSectionControllers = [TextEditingController()];
  late List<String> optionslist;
  final _formKey= GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController _RollNoController = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController _classNameController = TextEditingController();
  //List<TextEditingController> questionsInSectionControllers = [];
   int totalRollDigits = 0;
   String? _selectedSet;
   CreateOmrPdf createpdf =CreateOmrPdf();
  PDFservices pdfgenerate = PDFservices();
  omrHeader head =omrHeader();
  omrRange80 sheet= omrRange80();
  omrRangenew sheetnew= omrRangenew();
  int totalmcq =4;
  //omrRange120 sheet1= omrRange120();
  //omrRange160 sheet2=omrRange160();
  //omrRange225 sheet3= omrRange225();
  
 
 
  @override
  void initState() {
    super.initState();
    optionslist = ['A', 'B', 'C', 'D', 'E'];
    // Initialize controllers for each section
    for (int i = 0; i < totalSections; i++) {
      questionsInSectionControllers.add(TextEditingController());
    }  
   
   // Initialize with -1
  }
    @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in questionsInSectionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    List<String> capitalLetters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
     List<String> fname = firstname.text.split("");
    List<String> lname = lastname.text.split("");
   
    double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom OMR Sheets'),
      ),
      body: Container(
        child:SingleChildScrollView(child:
           Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Row(children: [
                   
                    Expanded(child: 
                    TextFormField(controller: _RollNoController,
                    decoration: InputDecoration(labelText: 'Roll No.'),
                    keyboardType: TextInputType.number,
                    validator: (value) {if (value!.isEmpty) {return 'Please enter Roll No.';}return null;},),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height: wid * 0.3,
                      width: wid * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/images/pdf.png'),
                    ),
                  ],),
                  TextFormField(controller: firstname,
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {if (value!.isEmpty) {return 'Please enter Name';}return null;},),
                  TextFormField(controller: lastname,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {if (value!.isEmpty) {return 'Please enter Name';}return null;},),
                  TextFormField(controller: _classNameController,decoration: InputDecoration(labelText: 'Class'),),
                  Row(children: [ 
                    SizedBox(child: Text('total mcqs in question'),),
                    SizedBox(width: 5,),
                    DropdownButton<int>(value: totalmcq,
                       onChanged: (int? newValue) {
                                  setState(() {totalmcq = newValue!;});},
                     items: <int>[4,5].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(value: value,child: Text('        $value'),);}).toList(),hint: Text('Select a set'), ),
                    ],),
                  Row(children: [ 
                    SizedBox(child: Text('Select Set'),),
                    SizedBox(width: 60,),
                    DropdownButton<String>(value: _selectedSet,
                       onChanged: (String? newValue) {
                                  setState(() {_selectedSet = newValue;});},
                     items: <String>['A', 'B', 'C', 'D'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value,child: Text(value),);}).toList(),hint: Text('Select a set'), ),
                    ],),
                    DropdownButtonFormField<int>(value: totalSections,
                        decoration: InputDecoration(labelText: 'Total Sections'),
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(value: index + 1,
                             child: Text('${index + 1}'),);
                          }),
                        onChanged: (value) {
                               setState(() {
                               totalSections = value!;
                               questionsInSection = List.generate(totalSections, (index) => index < questionsInSection.length ? questionsInSection[index] : 0);
                               questionsInSectionControllers = List.generate(totalSections, (index) => index < questionsInSectionControllers.length ? questionsInSectionControllers[index] : TextEditingController());
                                });
                                },
                      validator: (value) {
                          if (value == null) {
                               return 'Please select total sections';
                              }
                           return null;
                               },
                              ),
                      ListView.builder(
                     shrinkWrap: true,itemCount: totalSections,
                       itemBuilder: (context, index) {
                             return TextFormField(
                            controller: questionsInSectionControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Questions in Section ${index + 1}'),
                            validator: (value) {
                            if (value!.isEmpty) {
                                      return 'Please enter total questions in this section';
                                }
                               return null;
                                },
                             onChanged: (value) {
                                setState(() {
                                     questionsInSection[index] = int.tryParse(value) ?? 0;
                                  });
                              },
                             );
                               },
                            ),
                  
                  Center(child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        submit_details(fname,lname,hght,wid,capitalLetters) ;
                      },
                 style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white),
                 child: const Text("Create Omr Sheet")
                    ),
                  ),)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

submit_details(fname,lname,hght,wid,capitalLetters) async{
  //generating aruco marker  indexes
   Random random = Random();
   List<pw.Image> ArucoImages = [];
  List<pw.Image> ArucoImages2 = [];
  List<pw.Image> ArucoImages3 = [];
  List<pw.Image> ArucoImages4 = [];
   for (int i = 0; i < 4; i++) {
              
    final img = await rootBundle.load('assets/DICT/$i.png');
    final img2 = await rootBundle.load('assets/DICT/${i+4}.png');
    final img3 = await rootBundle.load('assets/DICT/${i+8}.png');
    final img4 = await rootBundle.load('assets/DICT/${i+12}.png');
    final imageBytes = img.buffer.asUint8List(); 
    final imageBytes2 = img2.buffer.asUint8List(); 
    final imageBytes3 = img3.buffer.asUint8List(); 
    final imageBytes4 = img4.buffer.asUint8List(); 
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
    pw.Image image2 = pw.Image(pw.MemoryImage(imageBytes2));
    pw.Image image3 = pw.Image(pw.MemoryImage(imageBytes3));
    pw.Image image4 = pw.Image(pw.MemoryImage(imageBytes4));
    ArucoImages.add(image1);
    ArucoImages2.add(image2);
    ArucoImages3.add(image3);
    ArucoImages4.add(image4);
    } 
     if (_formKey.currentState!.validate()) {
      int totalQuestions = questionsInSection.reduce((value, element) => value + element);
      if(totalQuestions>400){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text('Total questions exceed 400. Please reduce the number of questions.'),),);
      }
      if(_RollNoController.text.length>9){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text('Roll Number exceeds more than 9 digits '),),);
      }else{
        List<String> rollno = _RollNoController.text.split("");
        List<String> fullname =[];
         String? set =_selectedSet;
         String ins = "This omr contains ${questionsInSection.length} Sections. ";
         for (int i = 0; i < questionsInSection.length; i++) {
            if (i == 0) {
                if(questionsInSection[i]==0){
                    ins = ins + "Section ${i + 1} contains 0 questions";
                 }else{
                     ins = ins + "Section ${i + 1} contains questions from 1 to ${questionsInSection[i]}";
                }
              } else {
                 int totalQuestionsTillPreviousSection = questionsInSection.sublist(0, i).reduce((value, element) => value + element);
                  if(questionsInSection[i]==0){
                      ins = ins + " , Section ${i + 1} contains 0 questions";
                  }else{
                      ins = ins + " , Section ${i + 1} contains questions from ${totalQuestionsTillPreviousSection + 1} to ${totalQuestionsTillPreviousSection + questionsInSection[i]}";
                  }}
               }
                print(ins);
                for(int i =0;i<fname.length;i++){
                  fullname.add(fname.elementAt(i));
                 }
                 fullname.add(" ");
                 for(int i =0;i<lname.length;i++){
                   fullname.add(lname.elementAt(i));
                 }
                 for(int i =0;i<20;i++){
                   fullname.add("");
                 }
                  print("full name :$fullname");
                  print('Class Name: ${_classNameController.text}');
                  print('Total Questions: $totalQuestions');
                  print(questionsInSection);
                  final pdf = pw.Document();
                  if(totalQuestions<=56){
                    pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                      marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                      ,build: (pw.Context context) { 
                        return pw.Center(child:_content(context,hght,wid,optionslist,capitalLetters,totalQuestions,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages,ArucoImages4,totalmcq));},));
                    final data = await pdfgenerate.genpdf(pdf);
                    pdfgenerate.savepdffile("omrSheet", data);
                   }
                  if(totalQuestions>56 && totalQuestions<=228){
                    pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                       marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                      ,build: (pw.Context context) { 
                       return pw.Center(child:_content(context,hght,wid,optionslist,capitalLetters,56,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages,ArucoImages4,totalmcq));},));
              
                     pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                        marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                        ,build: (pw.Context context) { 
                        return pw.Center(child:_content2(context,hght,wid,optionslist,capitalLetters,totalQuestions-56,56,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages2,totalmcq));},));
                     
                     final data = await pdfgenerate.genpdf(pdf);
                      pdfgenerate.savepdffile("omrSheet", data);
                     }
                    else{
                     pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                              marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                              ,build: (pw.Context context) { 
                              return pw.Center(child:_content(context,hght,wid,optionslist,capitalLetters,56,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages,ArucoImages4,totalmcq));},));
              
                    pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                                marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                                ,build: (pw.Context context) { 
                                return pw.Center(child:_content2(context,hght,wid,optionslist,capitalLetters,172,56,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages2,totalmcq));},));
                         
                    pdf.addPage(pw.Page(pageTheme: pw.PageTheme( pageFormat:PdfPageFormat.a3.copyWith(
                                marginBottom: 15,marginLeft: 15,marginRight: 15,marginTop: 15,),orientation: pw.PageOrientation.portrait,)
                                ,build: (pw.Context context) { 
                                return pw.Center(child:_content2(context,hght,wid,optionslist,capitalLetters,totalQuestions-228,228,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages3,totalmcq));},));
                    final data = await pdfgenerate.genpdf(pdf);
                    pdfgenerate.savepdffile("omrSheet", data);
                   }
           }}
}

pw.Widget _content(pw.Context content,hght,wid,optionslist,letters,totalquestions,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages,ArucoImages4,totalmcq){ 
    return pw.Container(color: PdfColors.pink50,child: pw.Column(children: [
    pw.SizedBox(height: 10),
   /* pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages4[0]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages4[1])
    ]),*/
    head.header1(letters, hght, wid, optionslist, rollno, fullname, _selectedSet, _classNameController,_RollNoController),
     pw.SizedBox(height: 10),
    pw.Row(children:[
       pw.SizedBox(width: 20),
       pw.SizedBox(child: pw.Text("NOTE:",style: pw.TextStyle(height: 20,fontWeight:pw.FontWeight.bold)),),
       pw.SizedBox(width: 5),
       pw.Container(width:715,child: pw.Text(ins,style: pw.TextStyle(height: 20)),
          padding: pw.EdgeInsets.all(3),decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink))),
     ] ),
     
     pw.SizedBox(height: 10),
   /*  pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages4[2]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages4[3])
    ]),*/
    pw.SizedBox(height: 15),
    pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[0]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[1])
    ]),
    sheet.omrRow(totalquestions,totalmcq),
     pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[2]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[3])
    ]),
    
    ]));
    }

pw.Widget _content2(pw.Context content,hght,wid,optionslist,letters,totalquestions,start_index,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController,ArucoImages,totalmcq){
    return pw.Container(color: PdfColors.pink50,child: pw.Column(children: [
    pw.SizedBox(height: 20),
    pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[0]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[1])
    ]),
    sheetnew.omrRow(totalquestions,start_index,totalmcq),
     pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[2]),
      pw.SizedBox(height: 30,width: 730),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[3])
    ]),
    
    ]));
  
    }
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




/*

  if(80<totalquestions && totalquestions<=120 ){
    return pw.Container(color: PdfColors.pink50,child: pw.Column(children: [
    head.header2(letters, hght, wid, optionslist, rollno, fullname, _selectedSet, _classNameController, ins,_RollNoController),
     pw.SizedBox(height: 15),
    pw.Row(children: [
      pw.SizedBox(width: 20),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[0]),
      pw.SizedBox(height: 30,width: 715),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[1])
    ]),
    sheet1.omrRow(totalquestions),
    pw.Row(children: [
      pw.SizedBox(width: 20),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[2]),
      pw.SizedBox(height: 30,width: 715),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[3])
    ]),
    
    ]));
  }
  if(120<totalquestions && totalquestions<=160 ){
    return pw.Container(color: PdfColors.pink50,child: pw.Column(children: [
    head.header2(letters, hght, wid, optionslist, rollno, fullname, _selectedSet, _classNameController, ins,_RollNoController),
     pw.SizedBox(height: 10),
     pw.Row(children: [
      pw.SizedBox(width: 20),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[0]),
      pw.SizedBox(height: 30,width: 715),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[1])
    ]),
    sheet2.omrRow(totalquestions),
    pw.Row(children: [
      pw.SizedBox(width: 20),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[2]),
      pw.SizedBox(height: 30,width: 715),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[3])
    ]),
    ]));
  }
  else{
    return pw.Container(color: PdfColors.pink50,child: pw.Column(children: [
    head.header2(letters, hght, wid, optionslist, rollno, fullname, _selectedSet, _classNameController, ins,_RollNoController),
     pw.SizedBox(height: 10),
     pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[0]),
      pw.SizedBox(height: 30,width: 735),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[1])
    ]), 
    sheet3.omrRow(totalquestions),
    pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topLeft,child: ArucoImages[2]),
      pw.SizedBox(height: 30,width: 735),
      pw.Container(height: 30,width: 30,alignment:pw.Alignment.topRight,child: ArucoImages[3])
    ]),
    ]));
  }
 */