import 'package:flutter/material.dart';
import 'package:flutter_task_7/utilities/constants.dart';
import 'package:flutter_task_7/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  late int humidity; // Độ ẩm
  late int pressure; // Áp suất
  late AssetImage backgroundImage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        humidity = 0; // Đặt giá trị mặc định cho độ ẩm
        pressure = 0; // Đặt giá trị mặc định cho áp suất
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        backgroundImage = AssetImage('images/location_background.jpg');
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      humidity = weatherData['main']['humidity']; // Lấy độ ẩm từ dữ liệu thời tiết
      pressure = weatherData['main']['pressure']; // Lấy áp suất từ dữ liệu thời tiết
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      backgroundImage = getBackgroundImage(condition);
    });
  }

  AssetImage getBackgroundImage(int condition) {
    if (condition < 600) {
      return AssetImage('images/rainy.jpg');
    } else if (condition < 700) {
      return AssetImage('images/snow.jpg');
    } else if (condition == 804) {
      return AssetImage('images/clear.jpg');
    } else if (condition <= 800) {
      return AssetImage('images/cloud.jpg');
    } else {
      return AssetImage('images/location_background.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    int weatherCondition = 800;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Độ ẩm: $humidity%', // Hiển thị độ ẩm
                          style: kExtraInfoTextStyle,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Áp suất: $pressure hPa', // Hiển thị áp suất
                          style: kExtraInfoTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
