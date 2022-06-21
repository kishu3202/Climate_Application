import 'package:flutter/material.dart';

class locationCity extends StatefulWidget {
  const locationCity({Key? key}) : super(key: key);

  @override
  State<locationCity> createState() => _locationCityState();
}

class _locationCityState extends State<locationCity> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/location.webp'),
              fit: BoxFit.cover,
            ),
        ),
      ),
    );
  }
}
