import 'package:flutter/material.dart';
import 'package:weather/screens/newcityscreen.dart';


class secondscreen extends StatefulWidget {
  const secondscreen({super.key});

  @override
  State<secondscreen> createState() => _secondscreenState();
}

 Map Citylat = {
  'seoul': 37.5729,
 };
 Map Citylong = {
   'seoul': 126.9794,
 };

 var textcontroller = TextEditingController();
 String? inputText;

 var inputText_lat;
 var inputText_long;
 var cityinform = [];


class _secondscreenState extends State<secondscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(onPressed: (){
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return newcityscreen();
            //   },
            // ));
          },
            icon: Icon(Icons.location_searching), iconSize: 30.0,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SearchBar(
              leading: Icon(Icons.search),
              onSubmitted: (value) {
                setState(() {
                  inputText = value;
                  cityinform.add(Citylat[inputText]);
                  cityinform.add(Citylong[inputText]);
                  print(cityinform);


                }
                );
              },
            ),
            IconButton(onPressed: (){
              Navigator.pop(context, inputText_lat,);
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
