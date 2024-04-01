import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:omr_reader/CreateOmrPdf/CreateOmrPdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class omrRange80 {
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions){
  int num1=(totalquestions/20).toInt();
  int num2=(totalquestions%20).toInt();
  
  //pw.Image im = pw.Image(pw.MemoryImage(imageload()));
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width:47),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width:9),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<20;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
            pw.SizedBox(width: 21,child: pw.Text('${i*20 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 5, bottom:5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: 9),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
      child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
            pw.SizedBox(width: 21,child: pw.Text('${num1*20 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
            for(int i=0;i<(20-num2);i++)  pw.SizedBox(height: 24)     
  ]))]):pw.SizedBox(width: 5),
  ]));}
}      

class omrRangenew {
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions,start_index){
  int num1=(totalquestions/43).toInt();
  int num2=(totalquestions%43).toInt();
  
  //pw.Image im = pw.Image(pw.MemoryImage(imageload()));
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width:47),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width:9),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<43;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
            pw.SizedBox(width: 21,child: pw.Text('${i*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 5, bottom:5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: 9),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
      child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
            pw.SizedBox(width: 21,child: pw.Text('${num1*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
            for(int i=0;i<(43-num2);i++)  pw.SizedBox(height: 24)     
  ]))]):pw.SizedBox(width: 5),
  ]));}
}      




/*
class omrRange120 {
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions){
  int num1=(totalquestions/30).toInt();
  int num2=(totalquestions%30).toInt();
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width: 50,),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(margin: pw.EdgeInsets.all(3),padding: pw.EdgeInsets.all(3),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<30;j++)pw.Row(children: [
            pw.SizedBox(width: 2),
            pw.SizedBox(width: 22,child: pw.Text('${i*30 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(margin: pw.EdgeInsets.all(3),padding: pw.EdgeInsets.all(3),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
      child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            pw.SizedBox(width: 2),
            pw.SizedBox(width: 22,child: pw.Text('${num1*30 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
            for(int i=0;i<(30-num2);i++)  pw.SizedBox(height: 26)     
  ]))]):pw.SizedBox(width:5),
  ]));}
} 
class omrRange160{
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions){
  int num1=(totalquestions/40).toInt();
  int num2=(totalquestions%40).toInt();
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width: 45,),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<40;j++)pw.Row(children: [
            pw.SizedBox(width: 0),
            pw.SizedBox(width: 22,child: pw.Text('${i*40 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left:6, right: 6, top: 3, bottom: 3),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
      child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            pw.SizedBox(width: 0),
            pw.SizedBox(width: 22,child: pw.Text('${num1*40 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
            for(int i=0;i<(40-num2);i++)  pw.SizedBox(height: 20)     
  ]))]):pw.SizedBox(width:5),
  ]));}
} 
class omrRange225{
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions){
  int num1=(totalquestions/45).toInt();
  int num2=(totalquestions%45).toInt();
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width: 37,),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width: 7),
      pw.Container(margin: pw.EdgeInsets.all(2),padding: pw.EdgeInsets.all(2),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<45;j++)pw.Row(children: [
            pw.SizedBox(width: 0),
            pw.SizedBox(width: 22,child: pw.Text('${i*45 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left:4, right: 4, top: 2, bottom: 2),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: 7),
      pw.Container(margin: pw.EdgeInsets.all(2),padding: pw.EdgeInsets.all(2),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
      child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            pw.SizedBox(width: 0),
            pw.SizedBox(width: 22,child: pw.Text('${num1*45 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < 5; l++)pw.Container(margin: pw.EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
            for(int i=0;i<(45-num2);i++)  pw.SizedBox(height: 18)     
  ]))]):pw.SizedBox(width:5),
  ]));}
} 


*/