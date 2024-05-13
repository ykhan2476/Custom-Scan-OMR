import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omr_reader/checkSheet/answerkeytemplate.dart';

class Template extends StatefulWidget {
  const Template({Key? key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
List<TextEditingController> columnQuestionsControllers = [];
TextEditingController columns = TextEditingController();
TextEditingController mcqs = TextEditingController();  
TextEditingController posmarks = TextEditingController(); 
TextEditingController negmarks = TextEditingController(); 
 List<int> columnQuestionsCount = [];
final _formKey2= GlobalKey<FormState>();
int col = 0;
bool fill = false;
 @override
  void initState() {
    super.initState();
  }


   List<Widget> generateQuestions(int columns) {
    columnQuestionsCount = List.generate(columns, (index) => index < columnQuestionsCount.length ? columnQuestionsCount[index] : 0);
    for (int i = 0; i <columns; i++) {
    columnQuestionsControllers.add(TextEditingController());
    //columnQuestionsCount.add(0);
  }
    List<Widget> formfieldques = [];
    if(columns>0){
    for (int i = 0; i < columns; i++) {
      double wid = MediaQuery.of(context).size.width;
     formfieldques.add(Column(children: [
      SizedBox(child: Text( 'Questions in column ${i+1 }',style: TextStyle(fontSize: 12),)),
      Container(height: 40,width:wid*0.8,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
       border: Border.all(color: Color.fromARGB(255,13,71,161))),child:
          TextFormField(controller: columnQuestionsControllers[i],
           keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none),
           validator: (value) {
            if (value!.isEmpty) { return 'Please enter total questions in this column'; }
             return null;
            },
           onChanged: (value) {
              setState(() {
                columnQuestionsCount.length = columns; // Ensure list length
                    columnQuestionsCount[i] = int.parse(value);
                //columnQuestionsCount.add( int.parse( value));
               // columnQuestionsCount[i] = int.parse(value);
              }  
          ); }),   
     )],)); }}
      return formfieldques;
  }


  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(child: Column(
          children: [
            Container( width: wid, height: wid * 0.6,decoration: BoxDecoration(image: DecorationImage( 
                image: AssetImage('assets/images/scan2.jpg'),fit: BoxFit.cover,), ),),


            // OMR TEMPLATE 
            SizedBox( width: wid * 0.7, child: Text("OMR Template:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
            SizedBox(height: 20),
            Form(key: _formKey2,child: 
            Column( children: [
                SizedBox(height: 10),
                Text("Page 1",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color:Color.fromARGB(255,13,71,161) ),),
                SizedBox(height: 10),
                SizedBox(child: Text( 'Total Columns in page 1',style: TextStyle(fontSize: 12),)),
                Container(height: 40,width:wid*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255,13,71,161))),child:
                  TextFormField(controller: columns,decoration: InputDecoration(border: InputBorder.none,),
                  keyboardType: TextInputType.number,validator: (value) {
                    if (value!.isEmpty) {return '*required'; }
                    return null;},
                    onChanged: (value){
                      col = int.tryParse(value) ?? 0;
                      //columnQuestionsCount.clear();
                    
                    }
                ),),
                SizedBox(height: 5),
                Row(children: [
                SizedBox(width: wid*0.1),
                Column(children: [
                SizedBox(child: Text( '+ Marks',style: TextStyle(fontSize: 12),)),
                Container(height: 40,width:wid*0.2,decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255,13,71,161))),child: 
                  TextFormField(controller: posmarks,decoration: InputDecoration(border: InputBorder.none),
                   keyboardType: TextInputType.number,validator: (value) {
                    if (value!.isEmpty) {return "*required";}return null;},), ),
                    ],)
                ,SizedBox(width: 15),
                Column(children: [
                SizedBox(child: Text( '- Marks',style: TextStyle(fontSize: 12),)),
                Container(height: 40,width:wid*0.2,decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255,13,71,161))),child: 
                  TextFormField(controller: negmarks,decoration: InputDecoration(border: InputBorder.none),
                   keyboardType: TextInputType.number,validator: (value) {
                    if (value!.isEmpty) {return "*required";}return null;},), ),
                    ],)
                ,SizedBox(width: 15),
                Column(children: [
                SizedBox(child: Text( 'mcqs in question',style: TextStyle(fontSize: 12),)),
                Container(height: 40,width:wid*0.3,decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255,13,71,161))),child: 
                  TextFormField(controller: mcqs,decoration: InputDecoration(border: InputBorder.none),
                   keyboardType: TextInputType.number,validator: (value) {
                    if (value!.isEmpty) {return "*required";}return null;},), ),
                    ],)
          ],
        ),   
            ElevatedButton(
              style:ElevatedButton.styleFrom(backgroundColor:Colors.blue[900],foregroundColor: Colors.white),
              onPressed: (){
                setState(() {
                  fill = true;
                });
              }, child: Icon(Icons.arrow_forward)),
              if(fill==true)
            Column(children: generateQuestions(int.tryParse(columns.text) ?? 0),),
             SizedBox(height: 20),
             if(fill==true)
            Center(child:
            ElevatedButton(
              style:ElevatedButton.styleFrom(backgroundColor:Colors.blue[900],foregroundColor: Colors.white),
              onPressed: () {
                
                print(columnQuestionsCount);
                int questionssum = columnQuestionsCount.reduce((value, element) => value + element);
                print(columns.text);
                print(mcqs.text);
                print(posmarks.text);
                print(negmarks.text);
               if(int.parse(mcqs.text) >6 ){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text('total mcq options should be less than or equal to 6 '),),);
               }
               else if(int.parse(mcqs.text) == 1 ){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text(" mcq options can't be 1  "),),);
               }
               else if(int.parse(mcqs.text) ==0 ){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text(" mcq options can't be 0  "),),);
               }
               else{
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                 answerkeytemplate(totalSections: int.parse(columns.text),
                                   questionsInSection:columnQuestionsCount,
                                    totalmcq: int.parse(mcqs.text), posMarks: "5", negMarks: "1", totalquestions:questionssum,)));
               }
                //answerkey( int.parse(columns.text),columnQuestionsCount,int.parse(mcqs.text));
                 
              },child: Text('Generate Answer Key'), ), )
             ],)
     )]),
      ),
    );
  }
}


