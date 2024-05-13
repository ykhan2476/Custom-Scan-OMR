import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:omr_reader/checkSheet/ScanResult.dart';

class ImagePickerScreen extends StatefulWidget {
  final List<List<dynamic>> AnsKey;
  int totalmcq;
  final String posMarks;
  final String negMarks;
  final int totalquestions;
  ImagePickerScreen({Key? key,required this.posMarks,required this.negMarks,required this.AnsKey,required this.totalmcq,required this.totalquestions}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}
 
class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  List<Rect> regionsOfInterest = [];
  final picker = ImagePicker();
  late String option;
 

  

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print(widget.AnsKey);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //_image = ProcessImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }
  Future ClickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    print(widget.AnsKey);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //_image = ProcessImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }
 
  ConvertToString(number){
  List<String> options = ['A', 'B', 'C', 'D', 'E', 'F'];
  if (number >= 1 && number <= options.length) {
    return options[number - 1];
  } else {
    return '0'; // Handle out-of-range numbers
  }
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick Image'),
          content: Container(height: 50,child:Row(children: [
              IconButton(onPressed: getImage, icon:Icon(Icons.photo_library,color: Color.fromARGB(255,13,71,161),size: 40,),)
             ,IconButton(onPressed: ClickImage, icon:Icon(Icons.add_a_photo,color: Color.fromARGB(255,13,71,161),size: 40,),)
            ],) ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(child: Column(children: [
      SizedBox(height: 50,),
       SizedBox(height: 30,child: Text("OMR Sheet Details",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
      SizedBox(height: 10,),
      Container(margin: EdgeInsets.all(20),child: Text('Note: Please select an image from the gallery or capture one using the camera to scan the OMR sheet by clicking the image button below. Afterward, scroll down for further processing.'),),
      SizedBox(height: 10,),
    Card(elevation: 3,color: Colors.white,margin: EdgeInsets.all(10),shadowColor: Colors.grey,child: Column(children:[
      SizedBox(child: Text('Answer Key',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23)),),
      for(int i =0; i < widget.AnsKey.length;i++)
      Column(children: [
      SizedBox(height: 10,),
      SizedBox(child: Text('Column ${i+1}',style: TextStyle(color:Color.fromARGB(255,13,71,161) ,fontWeight: FontWeight.bold,fontSize: 18)),),
      Container(width: wid*0.9,child:
      Wrap(spacing: 8.0,runSpacing: 4.0, alignment: WrapAlignment.center, children:<Widget>[
        for(int j =0; j < widget.AnsKey[i].length;j++)
        Container(height: 30,width: 40,decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(child:Text('${j+1}. ${ConvertToString(widget.AnsKey[i][j])}',style: TextStyle(fontWeight: FontWeight.bold),),) ),
      ]) ,)],),
      SizedBox(height: 10,),
      ])),
        
    Card(elevation: 3,color: Colors.white,margin: EdgeInsets.all(10),shadowColor: Colors.grey,child: Column(children:[
      SizedBox(height: 10,width:wid*0.9,),
      SizedBox(child: Text('Positive  Marking : ${widget.posMarks}',style: TextStyle(color: Color.fromARGB(255,13,71,161),fontWeight: FontWeight.bold,fontSize: 16)),),
      SizedBox(child: Text('Negative  Marking : ${widget.negMarks}',style: TextStyle(color:Color.fromRGBO(255, 0, 22, 100),fontWeight: FontWeight.bold,fontSize: 16)),),
      SizedBox(child: Text('Total MCQs : ${widget.totalmcq}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),),
      SizedBox(height: 10,),])),
    Container(margin: EdgeInsets.all(20),child: Text('Note: OMR sheets should include Aruco markers on the boundary corners to facilitate scanning.'),),

      if(_image != null)
        Center(child: 
        Container(height: hght*0.3,width: wid*0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color:  Color.fromARGB(255,13,71,161))),
        clipBehavior: Clip.antiAlias,child:Image.file(_image!,fit: BoxFit.cover),
      ),),
      if(_image != null)
      ElevatedButton(
        onPressed: (){  print(widget.AnsKey); 
         Navigator.push( context,MaterialPageRoute(builder: (context) =>ScanResult(image: _image, posMarks: widget.posMarks, negMarks: widget.negMarks, AnsKey:widget.AnsKey, totalmcq: widget.totalmcq, totalquestions: widget.totalquestions,)),);
          }, 
        style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white),
        child: const Text("Check OMR Sheet",)),
      
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context); // Call function to show dialog
        },
        tooltip: 'Pick Image',backgroundColor: Color.fromRGBO(255, 0, 22, 100),foregroundColor: Colors.white,
        child: Icon(Icons.image),
      ),
    );
  }
}

