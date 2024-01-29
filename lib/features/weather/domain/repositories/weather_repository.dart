import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  /// RU: Получение информации о погоде по локации
  ///
  /// EN: Getting information about weather by location
  Future<WeatherModel> getWeatherInfo({required String location});
}
