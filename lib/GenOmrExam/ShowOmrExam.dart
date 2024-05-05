import 'package:flutter/material.dart';
import 'package:omr_reader/GenOmrExam/generateAnsKey.dart';

class ShowOmrExam extends StatefulWidget {
  final String Rollno;
  final String? Set;
  final String Name;
  final String className;
  final int totalSections;
  final int totalmcq;
  final List<int> questionsInSection;
  final String posMarks;
  final String negMarks;

  const ShowOmrExam({
    Key? key,
    required this.posMarks,
    required this.negMarks,
    required this.Rollno,
    required this.Name,
    required this.Set,
    required this.className,
    required this.totalSections,
    required this.totalmcq,
    required this.questionsInSection,
  }) : super(key: key);

  @override
  State<ShowOmrExam> createState() => _ShowOmrExamState();
}

class _ShowOmrExamState extends State<ShowOmrExam> {
  late List<List<int>> selectedOptions; // List of selected options for each section
  late List<List<int>> submittedOptions; 
  late int sections;
  late List<String> optionslist;
  late List<int> questions;
  late double hght;
  late double wid;
  String date = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  @override
  void initState() {
    super.initState();
    sections = widget.totalSections;
    optionslist = ['A', 'B', 'C', 'D', 'E'];
    questions = widget.questionsInSection;
    selectedOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), 0));
    submittedOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), -1)); // Initialize with -1
    
 
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = widget.questionsInSection.reduce((value, element) => value + element);
    hght = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;
    List<String> rollno = widget.Rollno.split("");
    List<String> details =[widget.Name,widget.className,widget.Rollno,widget.Set!,date,widget.posMarks,widget.negMarks,totalQuestions.toString()];
    return Scaffold(
      body: 
      SingleChildScrollView(scrollDirection: Axis.vertical,child: 
      Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.all(10),padding: EdgeInsets.all(10),child: Column(children: [
              SizedBox(height: 60,),
              Column(children: [
                  Text('ROLL NO.',style: TextStyle(fontSize: 20,color: Colors.pink,),),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [for(int i=0;i<rollno.length;i++)Container(height: 30,width: 30,padding: EdgeInsets.only(left: 10,top: 5),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink)),child: Text('${rollno[i]}'),)],),
                ],),
              SizedBox(height: 10,),
              Row(children: [
                SizedBox(width:6,),
                Column(children: [
                Container(height: 20,width: 200,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('NAME'),)
               ,Container(padding: EdgeInsets.all(3),height: 30,width: 200,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text('${widget.Name}'),),
                ],)
               ,
                SizedBox(width: 10,),
                Column(children: [ 
                Container(height: 20,width: 100,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('DATE'),)
               ,Container(padding: EdgeInsets.all(3),height: 30,width: 100,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text(date),),
                ],)
              ],),
              Row(children: [
                SizedBox(width:6,),
                Column(children: [
                  Container(height: 20,width: 155,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),child: Text('CLASS'),), 
                  Container(padding: EdgeInsets.all(3),height: 30,width: 155,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Text('${widget.className}'),),
                ],),
                SizedBox(width: 10,),
                Column(children: [ 
                 SizedBox(height: 20,),
                 Container(child: Row(children: [
                 Container(height: 29,width: 35,decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: const Color.fromARGB(255, 226, 176, 193)),
                   padding: EdgeInsets.only(top: 5),child: Text(' SET '),),
                 Container(decoration:BoxDecoration(border: Border.all(color: Colors.pink),color: Colors.white),child: Row(children: [
                 for(int i=0; i<4;i++)
                Container(margin: EdgeInsets.all(2),padding: EdgeInsets.only(left:5.5,right: 5.5,bottom: 5),height: 23,
                                 //decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.pink),borderRadius: BorderRadius.circular(100)),
                                 decoration: BoxDecoration(border:Border.all(color: (widget.Set.toString()==optionslist[i].toString())?Colors.black:Colors.pink),borderRadius: BorderRadius.circular(100),color:  (widget.Set.toString()==optionslist[i].toString())?Colors.black:Colors.white),
                                 child: Text(optionslist[i],style: TextStyle(color: (widget.Set.toString()==optionslist[i].toString())?Colors.white:Colors.pink),),)],),),
               ],),),
               SizedBox(height: 20,)
                ],)
              ],)
              
              /*  Container(child: Column(children:[
                 SizedBox(height:20,),
                Container(height: 25,width: wid*0.86,decoration:BoxDecoration(border: Border.all(color: Colors.pink),
                color: const Color.fromARGB(255, 226, 176, 193)),child: const Text('Instuctions For The Exam'),)
              ,Container(width: wid*0.86,decoration:BoxDecoration(border:Border.all(color: Colors.pink),
                color: Colors.white),child: const Text('1.'),)
              ]
              ),),*/
              
              ],),),
              Container(margin: EdgeInsets.all((widget.totalmcq==4)?20:10),padding: EdgeInsets.all((widget.totalmcq==4)?20:10),child: Column(children: [
              for (int i = 0; i < sections; i++)
                  Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      child: Text('SECTION ${i + 1}',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: questions[i],
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index + 1).toString(),style: TextStyle(fontWeight:FontWeight.bold),),
                          title: Container(
                            height: wid * 0.115,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int j = 0; j < widget.totalmcq; j++)
                                  MaterialButton(
                                    height: wid*0.115,
                                    minWidth: 10,
                                    color: selectedOptions[i][index] == j+1
                                        ? Colors.black // Change background color if selected
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                        color: selectedOptions[i][index] == j+1
                                            ? Colors.black
                                            : Colors.pink,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedOptions[i][index] = j+1;
                                      });
                                    },
                                    child: Text(
                                      optionslist[j],
                                      style: TextStyle(
                                        color: selectedOptions[i][index] == j+1
                                            ? Colors.white
                                            : Colors.pink,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ElevatedButton(onPressed: (){
                
                submittedOptions = List.from(selectedOptions);
                print(submittedOptions);
                Navigator.push(context,MaterialPageRoute(builder: (context) => 
                generateAnsKey(submittedOptions: submittedOptions, totalSections2: sections, questionsInSection2: questions, totalmcq: widget.totalmcq, details:details,)));
              },
              style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white), 
              child: Text('SUBMIT'))])),
            ],
          ),
        ),
      ),
    );
  }
}

