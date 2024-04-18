import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen(this.locationWeather, {super.key});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? temperatureIcon;
  String? conditionIcon;
  String? cityName;
  int? temperature;

  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      conditionIcon = "Error";
      cityName = "Unable to get current location";
      temperatureIcon = "";
      return;
    }

    setState(() {
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt();
      int condition = weatherData["weather"][0]["id"];
      conditionIcon = weather.getWeatherIcon(condition);
      cityName = weatherData["name"];
      temperatureIcon = weather.getMessage(temperature!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("assets/images/bckgrndImg.jpeg"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop)),
        ),
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {

                      if ( await Permission.location.serviceStatus.isEnabled){
PermissionStatus permissionStatus =
                          await Permission.location.status;
                      if (permissionStatus == PermissionStatus.granted) {
                        var weatherData = await weather.getWeatherLocation();
                        updateUI(weatherData);
                      }
                      if (permissionStatus == PermissionStatus.denied){
                        if(!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          content: Column(
                          children: [
                            Text("The location permission must be granted",
                            style: TextStyle(
                              color: Colors.deepPurple
                            ),
                            ),

                            Text("The Weather cannot be load",
                            style: TextStyle(
                              color: Colors.deepPurple
                            ),
                            ),

                          ],
                        )));
                        Map<Permission, PermissionStatus> permissionStatus = await [Permission.location].request();
                        var weatherData = await weather.getWeatherLocation();

                        updateUI(weatherData);
                      }
                      if (permissionStatus == PermissionStatus.permanentlyDenied){
                        openAppSettings();
                        Map<Permission, PermissionStatus> permissionStatus = await [Permission.location].request();

                        var weatherData = await weather.getWeatherLocation();

                        updateUI(weatherData);

                      }
                      }
                      else{
                        if(!context.mounted)return;
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enable location")));
                      }
                      
                    },
                    icon: const Icon(
                      Icons.near_me,
                      size: 50,
                    )),
                IconButton(
                    onPressed: () async {
                      var userCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      if (userCityName != null) {
                        var weatherData =
                            await weather.getCityWeather(userCityName);
                        updateUI(weatherData);
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50,
                    ))
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text("$temperature°", style: kTempTextStyle),
                    Text(conditionIcon!, style: kConditionTextStyle)
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text('$temperatureIcon in $cityName',
                    textAlign: TextAlign.right, style: kMessageTextStyle))
          ],
        ),
      )),
    );
  }
}
