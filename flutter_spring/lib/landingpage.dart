import 'dart:async';


import 'package:fllutter_spring/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget{
  @override
  _LadingPageState createState() => _LadingPageState();
}

class _LadingPageState extends State<LandingPage>{
  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      Get.to(MainPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.orange,
            child: Center(child: Text("hello world"),),
          ),
          CircularProgressIndicator()
        ],
      )
    );
  }
}