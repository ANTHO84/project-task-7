import 'package:flutter_task_7/services/location.dart';
import 'package:flutter_task_7/services/networking.dart';

const apiKey = '450dfe19680707fc8096f104812c9d6e';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
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
    if (temp > 30) {
      return 'Bạn nên nằm trong máy lạnh';
    }else if (temp > 25) {
      return 'Một ngày thật đẹp để uống trà sữa ';
    }else if (temp > 20) {
      return 'Ra ngoài tập thể dục thôi nào';
    } else if (temp < 10) {
      return 'Bạn nên giữ ấm cơ thể';
    } 
    else {
      return 'Lạnh lém';
    }
  }
}
