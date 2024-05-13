import 'package:flutter/material.dart';

class showSheet extends StatefulWidget {
  final String heading;
  final String subheading;
  final String className;
  final int totalSections;
  final List<int> questionsInSection;

  const showSheet({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.className,
    required this.totalSections,
    required this.questionsInSection,
  }) : super(key: key);
 

  @override
  State<showSheet> createState() => _showSheetState();
}

class _showSheetState extends State<showSheet> {
  late String heading;
  late String subheading;
  late String className;
  late int sections;
  late List<String> optionslist;
  late List<int> questions;
  late double hght;
  late double wid;

  @override
  void initState() {
    super.initState();
    heading = widget.heading;
    subheading = widget.subheading;
    className = widget.className;
    sections = widget.totalSections;
    optionslist = ['A', 'B', 'C', 'D', 'E'];
    questions = widget.questionsInSection;
   // Initialize with -1
  }

  @override
  Widget build(BuildContext context) {
    hght = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;
    return Scaffold(
     
      body: 
      SingleChildScrollView(scrollDirection: Axis.vertical,child: 
      Container(color: Color.fromARGB(255, 248, 219, 229),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Row(children: [
                SizedBox(width:6,),
                Column(children: [
                Container(height: 20,width: 210,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('Name'),)
               ,Container(height: 30,width: 210,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text(''),),
                ],)
               ,
                SizedBox(width: 10,),
                Column(children: [ 
                Container(height: 20,width: 120,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('Answer Sheet No.'),)
               ,Container(height: 30,width: 120,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text(''),),
                ],)
              ],),
              Row(children: [
                SizedBox(width: 6,),
                Column(children: [
                  Text('ROLL NO.',style: TextStyle(fontSize: 20,color: Colors.pink,),),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [for(int i=0;i<6;i++)Container(height: 30,width: 30,padding: EdgeInsets.only(left: 10,top: 5),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink)),child: Text(''),)],),
              Container(width: 30*6,alignment:Alignment.center,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink)),child:
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                for(int i=0;i<6;i++)Container(margin: EdgeInsets.all(1),color: i %2==0 ?const Color.fromARGB(255, 226, 176, 193):Colors.white,child:Column(children: [
                  for(int j=0;j<10;j++)
                   Container(margin: EdgeInsets.all(1),padding: EdgeInsets.only(left:7.5,right:7.5,bottom:5),height: 25,
                                 decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink),borderRadius: BorderRadius.circular(100)),
                                 child: Text("${j}",style: TextStyle(color: Colors.pink,),),),
                ],))
              ],),)
                ],),SizedBox(width: 10,),
                SizedBox(height:30,),
              Column(children: [
                SizedBox(height: 20,),
                Container(child: Row(children: [
                 Container(height: 31,width: 40,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),
                 padding: EdgeInsets.only(top: 5),child: Text(' SET '),),
                Container(decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Row(children: [
                for(int i=0; i<4;i++)
                Container(margin: EdgeInsets.all(2),padding: EdgeInsets.only(left:5.5,right: 5.5,bottom: 5),height: 25,
                                 decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink),borderRadius: BorderRadius.circular(100)),
                                 child: Text(optionslist[i],style: TextStyle(color: Colors.pink,),),)],),),
               ],),),
               SizedBox(height: 20,),
                Container(height: 20,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('Class'),)
               ,Container(height: 30,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text(''),),
               
               SizedBox(height: 20,),
               Container(height: 50,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),),
               Container(height: 20,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('Student Signature'),)
              
               ,SizedBox(height: 20,),
               Container(height: 50,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),),
               Container(height: 20,width: 150,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('Invigilator Signature'),),
               //SizedBox(height: 20,),
               
               SizedBox(height: 10,),
               Text('Date:__/__/____',style: TextStyle(fontSize: 18),),
              ],)
              ],),
                Container(child: Column(children:[
                 SizedBox(height:20,),
                Container(height: 25,width: wid*0.93,decoration:BoxDecoration(border: Border.all(color: Colors.pink),
                color: const Color.fromARGB(255, 226, 176, 193)),child: const Text('Instuctions For Filling The Sheet'),)
              ,Container(width: wid*0.93,decoration:BoxDecoration(border:Border(left: BorderSide(color: Colors.pink),right: BorderSide(color: Colors.pink),),
                color: Colors.white),child: const Text('1.This sheet should not be folded or crushed.\n2. Use only blue/black ball point pen to fill the circles.\n3. Use of pencils is strictly prohibited.\n4. Circles should be darkened completely and properly.\n5. Multiple markings will be treated as invalid response.'),)
              ,Container(width: wid*0.93,decoration: BoxDecoration(border:Border(left: BorderSide(color: Colors.pink),right: BorderSide(color: Colors.pink),bottom: BorderSide(color: Colors.pink))),clipBehavior: Clip.antiAlias,child: Image.asset('assets/images/omr.png'),)
              ]
              ),),
                 SizedBox(height:10,),
                 for (int i = 0; i < sections; i++)
                 Column(children: [
                 Container(
                      child: Text('SECTION ${i + 1}',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18)),
                    ),
                    Container(margin: EdgeInsets.all(17),
                    decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink)),child:
                    Row(children: [Column(children: [
                   Container(child:
                  Row(
                  children: [
                       Container(width: wid*0.42,
                    margin: EdgeInsets.only(left:5,top: 0),
                     child: 
                    ListView.builder(padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount:questions[i]- (questions[i]/2).toInt(),
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.only(bottom: 0,top: 0),
                        child:ListTile(contentPadding:EdgeInsets.all(0),
                          title: Row(mainAxisSize: MainAxisSize.min,children: [
                                SizedBox(width: 20,child:
                                Text((index + 1).toString(),style: TextStyle(fontWeight:FontWeight.bold),),),
                                //SizedBox(width: 2,),
                                for (int j = 0; j < 5; j++)
                                Container(margin: EdgeInsets.all(1),padding: EdgeInsets.only(left:5.5,right: 5.5,bottom: 5),height: 25,
                                 decoration: BoxDecoration(border: Border.all(color: Colors.pink),borderRadius: BorderRadius.circular(100)),
                                 child: Text(optionslist[j],style: TextStyle(color: Colors.pink,),),),
                              ],
                            ),
                        ));
                      },
                    ),
                  ),Column(children: [
                  Container(width: wid*0.42,
                    margin: EdgeInsets.only(left: 8,top: 0),
                      child: 
                    ListView.builder(padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: (questions[i]/2).toInt(),
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.only(bottom: 0,top: 0),
                        child:ListTile(contentPadding:EdgeInsets.all(0),
                          title: Row(mainAxisSize: MainAxisSize.min,children: [
                                SizedBox(width: 20,child:
                                Text((index + 1 +questions[i]- (questions[i]/2).toInt()).toString(),style: TextStyle(fontWeight:FontWeight.bold),)),
                                for (int j = 0; j < 5; j++)
                                Container(margin: EdgeInsets.all(1),padding: EdgeInsets.only(left:5.5,right: 5.5,bottom: 5),height: 25,
                                 decoration: BoxDecoration(border: Border.all(color: Colors.pink),borderRadius: BorderRadius.circular(100)),
                                 child: Text(optionslist[j],style: TextStyle(color: Colors.pink,),),),
                              ],
                            ),
                        ));
                      },
                    ), 
                  ),
                  questions[i]%2!=0?
                 SizedBox(height: 55,)
                 :SizedBox(height: 0,)])
                    ],),),
              
            ],
            
          ),
         
            ],),
          
    )],),  ElevatedButton(onPressed: (){print(questions);
              }, child: Text('SUBMIT'))]))),
    );
  }
}
