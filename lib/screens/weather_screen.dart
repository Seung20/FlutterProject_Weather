
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:datecouresmap/model/model.dart';

//https://github.com/icodingchef/lecture

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.weatherData, this.airData});
  final dynamic weatherData;
  final dynamic airData;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  int? temp;
  Widget? icon;
  Widget? AirIcon;
  Widget? AirText;
  double? dust1;
  double? dust2;
  String? des;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.weatherData, widget.airData);
  }

  void updateData(dynamic weatherData, dynamic airData){

    double temp2 = weatherData['main']['temp'];
    temp = temp2.round();
    cityName = weatherData['name'];
    int condition = weatherData['weather'][0]['id'];
    icon = model.getWeatherIcon(condition);
    des = weatherData['weather'][0]['description'];
    int index = airData["list"][0]['main']['aqi'];
    print(index);
    AirIcon = model.getAirIcon(index);
    AirText = model.getAirCondition(index);

    dust1 = airData["list"][0]["components"]["pm2_5"];
    dust2 = airData["list"][0]["components"]["pm10"];


    // print(temp);
    // print(cityName);

  }

  String? getSystemtime(){
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: (){},
          iconSize: 30.0,
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.location_searching), iconSize: 30.0,)
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.jpg'
            ,fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 150,),
                            Text('$cityName', style: GoogleFonts.lato(
                              fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white
                            ),),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                    (Duration(minutes:1)),
                                  builder: (context){
                                      print('${getSystemtime()}');
                                      return Text(
                                        '${getSystemtime()}' ,
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      );
                                  },
                                ),
                                Text(DateFormat(' - EEEE, ').format(date),
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ) ,),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ) ,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  icon!,
                                  // SizedBox(height: 10,),
                                  Text('$des', style: GoogleFonts.lato(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ) ,),
                                ],
                              ),
                            ),
                            Text('$temp\u2103', style: GoogleFonts.lato(
                                fontSize: 85.0, fontWeight: FontWeight.w300, color: Colors.white
                            ),),

                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('AQI(대기질지수)', style: GoogleFonts.lato(
                                fontSize: 14.0,
                                color: Colors.white,
                              ) ,),
                              SizedBox(
                                height: 10.0,
                              ),
                             AirIcon!,
                              SizedBox(
                                height: 10.0,
                              ),
                              AirText!,
                            ],
                          ),
                          Column(
                            children: [
                              Text('미세먼지', style: GoogleFonts.lato(
                                fontSize: 14.0,
                                color: Colors.white,
                              ) ,),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('$dust2', style: GoogleFonts.lato(
                                fontSize: 24.0,
                                color: Colors.white,
                              ) ,),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('㎍/㎥', style: GoogleFonts.lato(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ) ,),
                            ],
                          ),
                          Column(
                            children: [
                              Text('초미세먼지', style: GoogleFonts.lato(
                                fontSize: 14.0,
                                color: Colors.white,
                              ) ,),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('$dust1', style: GoogleFonts.lato(
                                fontSize: 24.0,
                                color: Colors.white,
                              ) ,),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('㎍/㎥', style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ) ,),
                            ],
                          ),

                        ],
                      )
                    ],

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
