import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  
  const CityScreen({super.key});

  @override
  _CityScreenState createState() =>  _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  

  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon : const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: kTextFieldInputdecoration,
                  onChanged: (value) { 
                    cityName = value;


                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  if (cityName.isEmpty) {
                    showDialog(context: context,
                    
                     builder: (context){
                      
                        return AlertDialog(
                          
                          title: const Text("The city field is empty",
                          style: TextStyle(
                            color: Colors.deepPurple
                          ),),
                          content: TextButton(onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                          ),
                        );
                    });
                    return;
                  }
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
