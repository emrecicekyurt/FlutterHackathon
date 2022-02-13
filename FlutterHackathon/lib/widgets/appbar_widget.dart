import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



AppBar buildAppBar(BuildContext context) {


  return AppBar(
    leading: const BackButton(color:  Colors.black,),
    backgroundColor: Colors.white,
    title: Center(child: const Text("Profile Page", style: TextStyle(color: Colors.black),)),
    elevation: 0,
    actions: [ const BackButton(color:  Colors.transparent,)],
  
  );
}