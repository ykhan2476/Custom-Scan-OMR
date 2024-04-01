import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:percent_indicator/percent_indicator.dart';

class ResultPage extends StatelessWidget {
  final List<String> details;
  

  ResultPage({
    required this.details,
    
  });

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(onPressed: (){}, 
                 style:ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(246, 13, 21, 238)),
                 child: const Text("Share",style: TextStyle(color: Colors.white),)),
              SizedBox(width: 20,),
              ElevatedButton(onPressed: (){}, 
                 style:ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(246, 13, 21, 238)),
                 child: Text("Generate Report",style: TextStyle(color: Colors.white)))
            ],)
          ],
        ),
      )],),
    ));
  }
}


