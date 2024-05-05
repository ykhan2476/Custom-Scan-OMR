import 'package:pdf/widgets.dart';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode_widget/barcode_widget.dart';


class omrHeader{
  //header1
  pw.Widget header1(letters,hght,wid,optionslist,rollno,fullname,_selectedSet,_classNameController,_RollNoController){ 
  Random random = Random();
  int randomNumber = random.nextInt(200);
  String barcodeData = "${_RollNoController.text}" + "$_selectedSet" + "$randomNumber";
  print(" roll no. list : $rollno");
  double len2= rollno.length.toDouble();
  return pw.Row(children: [
     pw.SizedBox(width: 38),
       pw.Column(children: [
        pw.SizedBox(height: 20),
        pw.Text("Student's Name (In Block Letters Only) ",style: pw.TextStyle(fontSize: 18,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [for(int i=0;i<23;i++)pw.Container(height: 19,width: 19,padding: pw.EdgeInsets.only(left: 10,top: 5),
                decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text("${fullname[i].toUpperCase()}",style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),)],),
        pw.Container(width: 19*23,alignment:pw.Alignment.center,decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child:
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [
                for(int i=0;i<23;i++)pw.Container(margin: pw.EdgeInsets.all(1.5),color: i %2==0 ?PdfColors.pink100:PdfColors.white,child:pw.Column(children: [
                  for(int j=0;j<letters.length;j++)
                   pw.Container(margin: pw.EdgeInsets.only(left: 1,right: 1,bottom: 2,top: 3),//padding: pw.EdgeInsets.only(left:7.5,right:7.5,bottom:5),
                   height: 14,width: 14,decoration: pw.BoxDecoration(color: (fullname[i].toUpperCase().toString()==letters[j].toString())?PdfColors.black:PdfColors.white,border: pw.Border.all(color:(fullname[i].toUpperCase().toString()==letters[j].toString())?PdfColors.black: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7)),
                                 child: pw.Center(child:pw.Text("${letters[j]}",style: pw.TextStyle(color: (fullname[i].toUpperCase().toString()==letters[j].toString())?PdfColors.black:PdfColors.pink,),),)),
                ],))
              ],),) ,
        
                ],),
      pw.SizedBox(width: 10),
      pw.Column(children: [
        pw.Container(height: 295,child: 
        pw.Row(children: [
              pw.Column(children: [
        pw.Center(child:pw.Text('ROLL NO.',style: pw.TextStyle(fontSize: 15,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),)),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [for(int i=0;i<rollno.length;i++)pw.Container(height:19,width:19,padding: pw.EdgeInsets.only(left: 10,top: 5),
                decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Center(child:pw.Text('${rollno[i]}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),)],),
        pw.Container(width: 19 *len2,alignment:pw.Alignment.center,decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child:
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [
                for(int i=0;i<rollno.length;i++)pw.Container(margin: pw.EdgeInsets.all(1.5),color: i %2==0 ?PdfColors.pink100:PdfColors.white,child:pw.Column(children: [
                  for(int j=0;j<10;j++)
                   pw.Container(margin: pw.EdgeInsets.all(1),//padding: pw.EdgeInsets.only(left:7.5,right:7.5,bottom:5),
                   height: 14,width: 14,decoration: pw.BoxDecoration(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.white,border: pw.Border.all(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.pink),borderRadius: pw.BorderRadius.circular(7)),
                                 child: pw.Center(child:pw.Text("${j}",style: pw.TextStyle(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.pink,),),)),
                ],))
              ],),) ,
         pw.SizedBox(height: 15),
         pw.Row(children: [
                pw.Container(height: 24,width: 58,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('SET'),)),
                pw.Container(height: 24,width: 74,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink50),child: pw.Row(children: [
                 for(int i =0;i<4;i++)pw.Container(margin: pw.EdgeInsets.all(2),height:14,width: 14,child: pw.Center(child:pw.Text(optionslist[i],style: pw.TextStyle())),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: (_selectedSet.toString()==optionslist[i].toString())?PdfColors.black:PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),color:  (_selectedSet.toString()==optionslist[i].toString())?PdfColors.black:PdfColors.white)),]))
               ]),
         pw.SizedBox(height: 15,),
         pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('Class'),)),
         pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),child: pw.Center(child:pw.Text('${_classNameController.text}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),)),     
                ],),
    pw.SizedBox(width: 5),
    pw.Column(children:[
               pw.Text('OMR SHEET',style: pw.TextStyle(fontSize: 19,fontWeight: pw.FontWeight.bold)),
               pw.SizedBox(height: 10,),
               pw.Container(height: 60,width: 110,padding:pw.EdgeInsets.all(10),decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),child:pw.BarcodeWidget(barcode: Barcode.code39(),data:'$barcodeData')),
               pw.SizedBox(height: 15,),
               pw.Container(height: 20,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child:pw.Center(child: pw.Text('Answer Sheet No.'),))
               ,
               pw.Container(height: 25,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),
                pw.SizedBox(height: 15,),
               pw.Container(height: 35,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),
               pw.Container(height: 20,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child:pw.Center(child: pw.Text('Student Signature'),))
               ,pw.SizedBox(height: 15,),
               pw.Container(height: 35,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),
               pw.Container(height: 20,width: 110,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('Invigilator Signature'),))
               
               ]),
        ]),),
        pw.Column(children:[
                pw.SizedBox(height: 20,),
                pw.Row(children: [
                  pw.Text('TEST DATE',style: pw.TextStyle(fontSize: 16,color: PdfColors.pink,),),
                  pw.SizedBox(width: 5),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [
                    for(int i=0;i<2;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                    pw.SizedBox(width: 10,),
                    for(int i=0;i<2;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                    pw.SizedBox(width: 10,),
                    for(int i=0;i<4;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                ],),
                ]),
                 pw.SizedBox(height: 20),
                pw.Container(padding: pw.EdgeInsets.only(left: 2),height: 25,width: wid*0.78,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),
                color: PdfColors.pink100),child:pw.Center(child:pw.Text('Instructions For Filling The Sheet',style:pw.TextStyle(fontSize: 12)),))
              ,pw.Container(padding: pw.EdgeInsets.all(3),height:130,width: wid*0.78,decoration:pw.BoxDecoration(border:pw.Border.all(color: PdfColors.pink),
                color: PdfColors.white),child: pw.Center(child:pw.Text('1.This sheet should not be folded or crushed.\n2. Use only blue/black ball point pen to fill the circles.\n3. Use of pencils is strictly prohibited.\n4. Circles should be darkened completely and properly.\n5. Multiple markings will be treated as invalid response.\n '
                ,style:pw.TextStyle(fontSize: 12.5))),),
              //pw.SizedBox(height: 22)
             //$ins
              ])]), ]);
} 
/*
//header2
  pw.Widget header2(letters,hght,wid,optionslist,rollno,fullname,_selectedSet,_classNameController,ins,_RollNoController){ 
  Random random = Random();
  int randomNumber = random.nextInt(200);
  String barcodeData = "${_RollNoController.text}" + "$_selectedSet" + "$randomNumber";
  print(" roll no. list : $rollno");
  double len2= rollno.length.toDouble();

  return pw.Row(children: [
     pw.SizedBox(width: 20),
       pw.Column(children: [
        pw.SizedBox(height: 10),
        pw.Text("Student's Name (In Block Letters Only) ",style: pw.TextStyle(fontSize: 18,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [for(int i=0;i<23;i++)pw.Container(height: 19,width: 19,padding: pw.EdgeInsets.only(left: 10,top: 5),
                decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text("${fullname[i].toUpperCase()}",style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),)],),
        pw.Row(children: [
          pw.Column(children: [
        pw.SizedBox(height: 5),
        pw.Center(child:pw.Text('ROLL NO.',style: pw.TextStyle(fontSize: 15,color: PdfColors.pink,fontWeight: pw.FontWeight.bold),)),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [for(int i=0;i<rollno.length;i++)pw.Container(height:19,width:19,padding: pw.EdgeInsets.only(left: 10,top: 5),
                decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Center(child:pw.Text('${rollno[i]}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),)],),
        pw.Container(width: 19 *len2,alignment:pw.Alignment.center,decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child:
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [
                for(int i=0;i<rollno.length;i++)pw.Container(margin: pw.EdgeInsets.all(1.5),color: i %2==0 ?PdfColors.pink100:PdfColors.white,child:pw.Column(children: [
                  for(int j=0;j<10;j++)
                   pw.Container(margin: pw.EdgeInsets.all(1),//padding: pw.EdgeInsets.only(left:7.5,right:7.5,bottom:5),
                   height: 14,width: 14,decoration: pw.BoxDecoration(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.white,border: pw.Border.all(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.pink),borderRadius: pw.BorderRadius.circular(7)),
                                 child: pw.Center(child:pw.Text("${j}",style: pw.TextStyle(color: (rollno[i]==j.toString())?PdfColors.black:PdfColors.pink,),),)),
                ],))
              ],),) ,]),
        pw.SizedBox(width: 10),
        pw.Column(children:[
               pw.SizedBox(height: 20,),
               pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('Class'),)),
               pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),child: pw.Center(child:pw.Text('${_classNameController.text}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),)), 
               pw.SizedBox(height: 10,),
               pw.Container(height: 40,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),
               pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child:pw.Center(child: pw.Text('Student Signature'),))
               ,pw.SizedBox(height: 10,),
               pw.Container(height: 40,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),
               pw.Container(height: 20,width: 150,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('Invigilator Signature'),))
               ]),
         pw.SizedBox(width: 10),
         pw.Column(children:[
                //pw.SizedBox(height: 5,),
                pw.Row(children: [
                  pw.Text('TEST DATE',style: pw.TextStyle(fontSize: 14,color: PdfColors.pink,),),
                  pw.SizedBox(width: 5),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children: [
                    for(int i=0;i<2;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                    pw.SizedBox(width: 10,),
                    for(int i=0;i<2;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                    pw.SizedBox(width: 10,),
                    for(int i=0;i<4;i++)pw.Container(height: 20,width: 20,padding: pw.EdgeInsets.only(left: 10,top: 5),
                    decoration: pw.BoxDecoration(color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Text(''),),
                ],),
                ]),
                 pw.SizedBox(height: 10),
                pw.Container(padding: pw.EdgeInsets.only(left: 2),height: 20,width: wid*0.9,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),
                color: PdfColors.pink100),child:pw.Center(child:pw.Text('Instructions For Filling The Sheet',style:pw.TextStyle(fontSize: 12)),))
              ,pw.Container(padding: pw.EdgeInsets.all(3),width: wid*0.9,decoration:pw.BoxDecoration(border:pw.Border.all(color: PdfColors.pink),
                color: PdfColors.white),child: pw.Center(child:pw.Text('1.This sheet should not be folded or crushed.\n2. Use only blue/black ball point pen to fill the circles.\n3. Use of pencils is strictly prohibited.\n4. Circles should be darkened completely and properly.\n5. Multiple markings will be treated as invalid response.\n6. $ins'
                ,style:pw.TextStyle(fontSize: 12.5))),)
              ])])
                ],),
      pw.SizedBox(width: 10),
      pw.Column(children: [
        pw.Row(children: [
    pw.Column(children:[
                pw.SizedBox(height: 50,),
               pw.Text('OMR SHEET',style: pw.TextStyle(fontSize: 20,fontWeight: pw.FontWeight.bold)),
               pw.SizedBox(height: 10,),
               pw.Container(height: 60,width: 130,padding:pw.EdgeInsets.all(10),decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),child:pw.BarcodeWidget(barcode: Barcode.code39(),data:'$barcodeData')),
               pw.SizedBox(height: 10,),
               pw.SizedBox(height: 10),
         pw.Row(children: [
                pw.Container(height: 22,width: 56,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child: pw.Center(child:pw.Text('SET'),)),
                pw.Container(height: 22,width: 74,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink50),child: pw.Row(children: [
                 for(int i =0;i<4;i++)pw.Container(margin: pw.EdgeInsets.all(2),height:14,width: 14,child: pw.Center(child:pw.Text(optionslist[i],style: pw.TextStyle())),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: (_selectedSet.toString()==optionslist[i].toString())?PdfColors.black:PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),color:  (_selectedSet.toString()==optionslist[i].toString())?PdfColors.black:PdfColors.white)),]))
               ]),
         pw.SizedBox(height: 10,),
         pw.Container(height: 20,width: 130,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.pink100),child:pw.Center(child: pw.Text('Answer Sheet No.'),)),
         pw.Container(height: 25,width: 130,decoration:pw.BoxDecoration(border: pw.Border.all(color: PdfColors.pink),color: PdfColors.white),),   
              
               ]),
        ]),
        
         ]), ]);
} */
}