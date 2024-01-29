import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherInfoScreen extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherInfoScreen({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    var weatherMain = weatherModel.main?.feelsLike;
    var tempMin = weatherModel.main?.tempMin;
    var tempMax = weatherModel.main?.tempMax;
    int sunriseTimestamp = 1706514254;
    int sunsetTimestamp = 1706546554;

    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

    return Scaffold(
      backgroundColor: Colors.blue[300],
      // appBar: AppBar(
      //   title: Text(
      //     "Текущая погода",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      // ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${weatherModel.name} - ${weatherModel.sys?.country}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text("${weatherModel.weather![0].description}"),
            Text(
                "Сейчас ощущается как: ${(weatherMain! - 273.15).toStringAsFixed(1)} C"),
            Text(
                "Минимальная температура: ${(tempMin! - 273.15).toStringAsFixed(1)} C"),
            Text(
                "Максимальная температура: ${(tempMax! - 273.15).toStringAsFixed(1)} C"),
            Text("Восход Солнца: ${sunriseDateTime.toLocal()}"),
            Text("Заход Солнца: $sunsetDateTime"),
          ],
        ),
      ),
    );
  }
}
