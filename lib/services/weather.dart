import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/services/networking.dart';
import '../services/location.dart';

class WeatherModel {
  final _openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkData networkData =
        NetworkData('$_openWeatherURL?q=$cityName&appid=${dotenv.env["API_KEY"]}&units=metric');
    var weatherData = await networkData.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkData networkData = NetworkData(
        "$_openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env["API_KEY"]}&units=metric");
    var weatherData = await networkData.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍹 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
