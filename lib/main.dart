import 'package:climate_app/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(ClimateApp());
}
class ClimateApp extends StatelessWidget {
  const ClimateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
