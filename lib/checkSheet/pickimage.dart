import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  List<Rect> regionsOfInterest = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //_image = ProcessImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50,),
        SizedBox(height: 30,child: Text("Pick OMR Image",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
        SizedBox(height: 20,),
        Center(child: 
        Container(height: hght*0.6,width: wid*0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color:  Color.fromARGB(255,13,71,161))),
        clipBehavior: Clip.antiAlias,child: _image == null
            ? Center(child:Text('No image selected.',style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Color.fromARGB(255,13,71,161) )))
            : Image.file(_image!,fit: BoxFit.cover),
      ),)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',backgroundColor: Color.fromARGB(255,13,71,161),foregroundColor: Colors.white,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

