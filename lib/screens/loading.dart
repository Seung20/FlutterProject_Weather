import 'package:flutter/material.dart';
import 'package:datecouresmap/data/my_location.dart';
import 'package:datecouresmap/data/network.dart';
import 'package:datecouresmap/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const apikey = '8e2b85dee1832f3d88dc87b66482d671';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3;
  double? longitude3;


  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    // print(latitude3);
    // print(longitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/'
        'weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
    'http://api.openweathermap.org/data/2.5/air_pollution?'
        'lat=$latitude3&lon=$longitude3&appid=$apikey');

    var weatherData  = await network.getJsonData();
    // print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(weatherData: weatherData, airData: airData,);
    }));

  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
     body: Center(
       child : SpinKitDoubleBounce(
         color: Colors.white,
         size: 80.0,
       ),
     ),

    );
  }
}
