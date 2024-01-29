// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepository;
  WeatherUseCase({required this.weatherRepository});

  Future<WeatherModel> getWeatherInfo({required String location}) async {
    return await weatherRepository.getWeatherInfo(location: location);
  }
}
