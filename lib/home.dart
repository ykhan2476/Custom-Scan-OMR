import 'package:flutter/material.dart';
import 'package:omr_reader/GenOmrExam/GenerateOmrExam.dart';
import 'package:omr_reader/ScanOmr/aruco.dart';
import 'package:omr_reader/CreateOmrPdf/CreateOmrPdf.dart';
import 'package:omr_reader/ScanOmr/pickimage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
 
    late File?   _image;
  final picker = ImagePicker();



Future<void> getImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image =File(pickedFile.path);
    });
  } else {
    print('No image selected.');
  }
}
void _navigateToImageScreen() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Aruco(image: _image!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('Please select an image from the gallery.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
void _navigateToImageScreen2() {
    if ( _image!= null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Aruco(image: _image!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('Please select an image from the gallery.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final File image;
    double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
    body: Container(margin: EdgeInsets.all(30),child: SingleChildScrollView(scrollDirection:Axis.vertical,child:Column(children: [
      
      SizedBox(height: 40,),
      SizedBox(child: Text('Custom Scan OMR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),     
    SizedBox(height: 40,),
    GestureDetector(onTap: (){Navigator.push( context,MaterialPageRoute(builder: (context) =>GenerateOmrExam() ),);},child:
    Card( elevation: 5, // Adjust elevation as needed
            child: Container(
              width: wid,height: wid*0.35, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                image: DecorationImage(image: AssetImage('assets/images/card1.jpg'), fit: BoxFit.cover, ),),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text('Take Exam',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            ),), ),
    GestureDetector(onTap: (){Navigator.push( context,MaterialPageRoute(builder: (context) =>CreateOmrPdf()));},child:
      Card( elevation: 5, // Adjust elevation as needed
            child: Container(
              width: wid,height: wid*0.35, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                image: DecorationImage(image: AssetImage('assets/images/card2.jpg'), fit: BoxFit.cover, ),),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text('Create OMR',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            ),), ),
    GestureDetector(onTap: (){Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen()),);},child:
      Card( elevation: 5, // Adjust elevation as needed
            child: Container(
              width: wid,height: wid*0.35, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                image: DecorationImage(image: AssetImage('assets/images/card3.jpg'), fit: BoxFit.cover, ),),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text('Scan OMR',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            ),), ),
    GestureDetector(onTap: (){
    
   
    _navigateToImageScreen();
   },child:
      Card( elevation: 5, // Adjust elevation as needed
            child: Container(
              width: wid,height: wid*0.35, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                image: DecorationImage(image: AssetImage('assets/images/card4.jpg'), fit: BoxFit.cover, ),),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text('Details',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            ),), ),
        ]),
      ),
  
    ));
  }
}

Widget _buildIconButtonWithLabel(IconData iconData, String label, Function onPressed) {
  return Container(
    decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 56, 169, 179),Colors.black],begin: Alignment.topCenter,end: Alignment.bottomCenter),
      //color: Colors.white, // Background color of the grid item
      border: Border.all(color: Colors.grey), // Border color of the grid item
      borderRadius: BorderRadius.circular(8.0), // Optional: Apply border radius
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(iconData),
          onPressed: onPressed as void Function()?,
          color: Colors.white, // Color of the icon
        ),
        SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white, // Color of the label text
          ),
        ),
      ],
    ),
  );
}