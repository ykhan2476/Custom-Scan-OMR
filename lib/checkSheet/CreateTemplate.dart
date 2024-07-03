import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omr_reader/checkSheet/Sets.dart';
import 'package:omr_reader/checkSheet/answerkeytemplate.dart';
import 'package:omr_reader/main.dart';

class CreateTemplate extends StatefulWidget {
  const CreateTemplate({Key? key});

  @override
  State<CreateTemplate> createState() => _CreateTemplateState();
}

class _CreateTemplateState extends State<CreateTemplate> {
List<TextEditingController> columnQuestionsControllers = [];
TextEditingController columns = TextEditingController();
TextEditingController mcqs = TextEditingController();  
TextEditingController posmarks = TextEditingController(); 
TextEditingController negmarks = TextEditingController(); 
 List<int> columnQuestionsCount = [];
 String? _selectedSet;
 int? questionssum;
List<Map<String, dynamic>> AnswerKeys = [];

  
final _formKey2= GlobalKey<FormState>();
int col = 0;
bool fill = false;
 @override
  void initState(){
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
              style:ElevatedButton.styleFrom(backgroundColor:Color.fromRGBO(255, 0, 22, 100),foregroundColor: Colors.white),
              onPressed: () {
                runApp(MyApp());
                print(columnQuestionsCount);
                
                setState(() {
                  questionssum = columnQuestionsCount.reduce((value, element) => value + element);
                });
                String TemplateName ='${mcqs.text}${posmarks.text.toString()}${negmarks.text.toString()}${questionssum!}${columns.text}';
                print(TemplateName);
                Map<String, dynamic> template = {
                  'templateName':TemplateName,
                  'totalmcq': int.parse(mcqs.text),
                  'posMarks': posmarks.text.toString(),
                  'negMarks':  negmarks.text.toString(),
                  'totalquestions':questionssum!,
                  'totalColumns':int.parse(columns.text),
                  'questionsInSection':columnQuestionsCount,
                };
                
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
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sets(Template: template, questionsInSection: columnQuestionsCount,)));
               /*  Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                 answerkeytemplate(totalSections: int.parse(columns.text),
                                   questionsInSection:columnQuestionsCount,
                                    totalmcq: int.parse(mcqs.text), posMarks:posmarks.text.toString(), negMarks: negmarks.text.toString(), totalquestions:questionssum!, set: _selectedSet!,)));
               */}
                //answerkey( int.parse(columns.text),columnQuestionsCount,int.parse(mcqs.text));
              
              },child: Text('NEXT'), ), ),


/*


             Container(margin: EdgeInsets.all(20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Color.fromARGB(255,13,71,161))),
             child: Column(children: [
                Row(children: [
                 SizedBox(width: 50,),
                 Text("Add new Set",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color:Color.fromARGB(255,13,71,161) ),),
                 SizedBox(width: 50,),
                 DropdownButton<String>(value: _selectedSet,
                       onChanged: (String? newValue) {
                                  setState(() {_selectedSet = newValue;});},
                     items: <String>['A', 'B', 'C', 'D','F','G','H'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value,child: Text('        $value'),);}).toList(),hint: Text('Select a set'), ),
             ],),
             
           
              SizedBox(height: 10,),

             
             ],),),
            for(int i=0;i<AnswerKeys.length;i++)
            Text('Set ${AnswerKeys[i]['Set']} saved '),
             
             
             
             //SizedBox(height: 10),
            ElevatedButton(
            onPressed: (){
              //Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen(AnsKey: FinalAnsKey, totalmcq: widget.totalmcq, posMarks: widget.posMarks, negMarks: widget.negMarks, totalquestions: widget.totalquestions, totalColumns: widget.totalSections,)),);

            }, 
            style:ElevatedButton.styleFrom(backgroundColor:Colors.blue[900],foregroundColor: Colors.white),
            child: Text('Check OMR Sheet'))

             */
            
             ],)
     )]),
      ),
    );
  }
}
                //Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen(AnsKey: FinalAnsKey, totalmcq: widget.totalmcq, posMarks: widget.posMarks, negMarks: widget.negMarks, totalquestions: widget.totalquestions, totalColumns: widget.totalSections,)),);
//      if(key.contains('${mcqs.text}${posmarks.text}${negmarks.text}$questionssum${int.parse(columns.text)}')){
