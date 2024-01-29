import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/internal/catch_exception.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUseCase weatherUseCase;
  WeatherBloc({required this.weatherUseCase}) : super(WeatherInitialState()) {
    on<GetWeatherInfoEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());

        try {
          final WeatherModel weatherModel =
              await weatherUseCase.getWeatherInfo(location: event.location);

          emit(WeatherLoadedState(weatherModel: weatherModel));
        } catch (e) {
          emit(WeatherErrorState(error: CatchException.convertException(e)));
        }
      },
    );
  }
}
