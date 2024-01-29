import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/internal/catch_exception.dart';

part 'global_localization_event.dart';
part 'global_localization_state.dart';

class GlobalLocalizationBloc
    extends Bloc<GlobalLocalizationEvent, GlobalLocalizationState> {
  GlobalLocalizationBloc() : super(GlobalLocalizationInitialState()) {
    on<ChangeLocalEvent>((event, emit) async {
      emit(GlobalLocalizationLadingState());



      try {
        setCurrentLocale(event.locale);

        String currentLocale = await getCurrentLocale();

        emit(GlobalLocalizationLadedState(locale: currentLocale));
      } catch (e) {
        emit(GlobalLocalizationErrorState(
            error: CatchException.convertException(e)));
      }
    });
  }
}

Future<void> setCurrentLocale(String currentLocale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("locale", currentLocale);
}

Future<String> getCurrentLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString("locale") ?? "ru";

  return value;
}
