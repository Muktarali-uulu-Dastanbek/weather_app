// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeatherInfoEvent extends WeatherEvent {
  final String location;

  GetWeatherInfoEvent({required this.location});
}
