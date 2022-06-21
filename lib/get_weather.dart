import 'dart:convert';
import 'package:climate_app/location_city.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetWeatherScreen extends StatefulWidget {
  final weatherData;
  const GetWeatherScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<GetWeatherScreen> createState() => _GetWeatherScreenState();
}

class _GetWeatherScreenState extends State<GetWeatherScreen> {
  var apikey = "ced3fdfcd12c7503e4847be70eaafb8a";
  var cityName;
  var currentWeather;
  var tempInCel;
  var emoji;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print(widget.weatherData['name']);
    updateUI(widget.weatherData);

  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/homescreen.png'),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    print(widget.weatherData['weather'][0]['main']);
                  },
                    icon: Icon(Icons.near_me, color: Colors.white, size: 40,),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => locationCity()));
                  },
                    icon: Icon(Icons.location_on, color: Colors.white, size: 40,),
                  ),
                ],
              ),
              Text(cityName, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text(tempInCel+"º",style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${emoji}", style: TextStyle(fontSize: 50),),
                  Text(currentWeather, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  String kelvinToCel(var temp){
    var tempInCel = temp-273.15;
    String tempInString = tempInCel.floor().toString();
    return tempInString;
  }

  Future<void> getweatherDataFromCityName(String cityName) async {
    var cityWeatherAPI = "api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}";
    var url = Uri.https("api.openweathermap.org", "/data/2.5weather",{'q': cityName , 'appid': apikey});
    print(url);
    var response = await http.get(url);
    var data = response.body;
    var weatherData = jsonDecode(data);
    updateUI(weatherData);
  }
  void updateUI(weatherData){
    var weatherid = weatherData['weather'][0]['id'];
    if(weatherid >200 && weatherid <300){
      setState(() {
        emoji = "🌩";
      });
    }
    else if(weatherid >300 && weatherid <400){
      setState(() {
        emoji = "⛈";
      });
    }
    else if(weatherid >500 && weatherid <600){
      setState(() {
        emoji = "☃️";
      });
    }
    else if(weatherid >700 && weatherid <800){
      setState(() {
        emoji = "☁️";
      });
    }
    else if(weatherid >= 800){
      setState(() {
        emoji = "⛅️";
      });
    }
    setState(() {
      var temp = weatherData['main']['temp'];
      tempInCel = kelvinToCel(temp);
      currentWeather = weatherData['weather']['0']['main'];
      cityName = weatherData['name'];
    });

  }
}
