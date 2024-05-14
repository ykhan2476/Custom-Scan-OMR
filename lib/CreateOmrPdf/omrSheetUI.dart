import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class omrRange80 {
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions,totalmcq){
  int num1=(totalquestions/14).toInt();
  int num2=(totalquestions%14).toInt();
  
  //pw.Image im = pw.Image(pw.MemoryImage(imageload()));
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width:47),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width:totalmcq!=5?22:18),
      pw.Column(children: [
        for (int j =0;j<14;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5,bottom: 5),width: 21,child: pw.Text('${i*14 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
      ]),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<14;j++)pw.Row(children: [
                for (int l = 0; l < totalmcq; l++)pw.Container(margin: totalmcq!=4?pw.EdgeInsets.all(5):pw.EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: totalmcq!=5?22:18),
      pw.Column(children: [
        for (int j =0;j<num2;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5,bottom: 5),width: 21,child: pw.Text('${num1*14 + j+1}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
      for (int j =0;j<14-num2;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5,bottom: 5),width: 21,height: 14),
      ]),
      pw.Column(children: [
        pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
           child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
                for (int l = 0; l < totalmcq; l++)pw.Container(margin: totalmcq!=4?pw.EdgeInsets.all(5):pw.EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
           //      
  ])),
  for(int i=0;i<(14-num2);i++)  pw.SizedBox(height: 24)
      ]),
      
  
  ]):pw.SizedBox(width: 5),
  ]));}
} 
   

class omrRangenew {
List<String> options=['A','B','C','D','E'];
pw.Widget omrRow(totalquestions,start_index,totalmcq){
  int num1=(totalquestions/43).toInt();
  int num2=(totalquestions%43).toInt();
  
  //pw.Image im = pw.Image(pw.MemoryImage(imageload()));
  return pw.Center(child:pw.Row(children: [
    pw.SizedBox(width:47),
    for(int i =0;i<num1;i++)
    pw.Row(children: [
      pw.SizedBox(width:totalmcq!=5?22:18),
       pw.Column(children: [
        for (int j =0;j<43;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5,bottom: 4.7),width: 21,child: pw.Text('${i*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
      ]),
      pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),child: pw.Column(children: [
           for (int j =0;j<43;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
            //pw.SizedBox(width: 21,child: pw.Text('${i*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < totalmcq; l++)pw.Container(margin: totalmcq!=4?pw.EdgeInsets.all(5):pw.EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)          
  ]))]),
  (num2!=0)?
   pw.Row(children: [
      pw.SizedBox(width: totalmcq!=5?22:18),
      pw.Column(children: [
        for (int j =0;j<num2;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5,bottom: 4.7),width: 21,child: pw.Text('${num1*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
      for (int j =0;j<43-num2;j++)
        pw.Container(margin:pw.EdgeInsets.only(top:5.3,bottom: 4.7),width: 21,height: 14),
      ]),
      pw.Column(children: [
          pw.Container(margin: pw.EdgeInsets.all(4),padding: pw.EdgeInsets.all(4),decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink)),
          child: pw.Column(children: [
           for (int j =0;j<num2;j++)pw.Row(children: [
            //pw.SizedBox(width: 1),
           // pw.SizedBox(width: 21,child: pw.Text('${num1*43 + j+1 + start_index}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),),
                for (int l = 0; l < totalmcq; l++)pw.Container(margin: totalmcq!=4?pw.EdgeInsets.all(5):pw.EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),height: 14,width: 14,
                    decoration: pw.BoxDecoration( color: PdfColors.white,border: pw.Border.all(color: PdfColors.pink),borderRadius: pw.BorderRadius.circular(7),),
                    child: pw.Center(child: pw.Text( "${options[l]}", style: pw.TextStyle(color: PdfColors.pink),),
                    ),),],)   ,
      
  ])),
  for(int i=0;i<(43-num2);i++)  pw.SizedBox(height: 24)  
  ])]):pw.SizedBox(width: 5),
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