
import 'package:flutter/material.dart';
import 'package:omr_reader/GenOmrExam/GenerateOmrExam.dart';
import 'package:omr_reader/CreateOmrPdf/CreateOmrPdf.dart';
import 'package:omr_reader/widget/animation.dart';
import 'package:omr_reader/checkSheet/template.dart';

class home extends StatefulWidget {
  const home({super.key,});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
     List Cardname =['Take Exam','Create OMR','Scan OMR','Details'];
     List CardImage=['assets/images/card1.jpg','assets/images/card2.jpg','assets/images/scan.png','assets/images/card4.jpg'];
    List cardfunc=[GenerateOmrExam(),CreateOmrPdf(),Template(),animation()];
    return Scaffold(
    body: Container(margin: EdgeInsets.all(30),child: SingleChildScrollView(scrollDirection:Axis.vertical,child:Column(children: [
      
      SizedBox(height: 30,),
      SizedBox(child: Text('Custom Scan OMR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:  Colors.blue[900]),),),     
    SizedBox(height: 20,),
    for(int i =0 ;i< Cardname.length;i++)
    GestureDetector(onTap: (){Navigator.push( context,MaterialPageRoute(builder: (context) =>cardfunc[i] ),);},child:
    Card( elevation: 5, // Adjust elevation as needed
            child: Container(
              width: wid,height: wid*0.35, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                image: DecorationImage(image: AssetImage(CardImage[i]), fit: BoxFit.cover, ),),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text(Cardname[i],
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            ),), ),
     

        ]),
      ),
  
    ));
  }
}
