import 'dart:async';
import 'package:flutter/material.dart';

import 'package:omr_reader/Home/footer.dart';


class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    _navigatehome();
    //y dusri screen k baad splash screen vps na aane k liye
  }

  _navigatehome() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => footer()));
  }

  @override
  Widget build(BuildContext context) {
  
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
            body: SingleChildScrollView(child:Column(children: [ 
            SizedBox(height: wid*0.6,),
            Center(child:
            Container(height: wid*0.7,width: wid*0.65,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo/ic_launcher.png'),fit: BoxFit.cover)), ),)
            ,
            SizedBox(height: 30,child: Text('CUSTOM SCAN OMR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            Center(child:Container(height: 30,width: 30,margin: EdgeInsets.only(top: 40,),child: CircularProgressIndicator(color: Color.fromRGBO(255, 0, 22, 100),),))],),),
    );
  }
}