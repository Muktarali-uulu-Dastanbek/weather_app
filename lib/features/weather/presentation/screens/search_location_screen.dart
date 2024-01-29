import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/features/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/screens/weather_info_screen.dart';

class SearchLocationScreen extends StatelessWidget {
  const SearchLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = WeatherBloc(
      weatherUseCase: WeatherUseCase(
        weatherRepository: WeatherRepositoryImpl(),
      ),
    );
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Прогноз погоды",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // title: Text(S.of(context).hello),
        centerTitle: true,
        backgroundColor: Colors.blue,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://news-ru.gismeteo.st/2019/07/ddbbcb35.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.name,
              maxLength: 20,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                // errorText: "Field is required",
                suffixIcon: BlocConsumer<WeatherBloc, WeatherState>(
                  bloc: weatherBloc,
                  listener: (context, state) {
                    if (state is WeatherLoadedState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherInfoScreen(
                            weatherModel: state.weatherModel,
                          ),
                        ),
                      );
                    }
                    if (state is WeatherErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.error.message.toString())));
                    }
                  },
                  builder: (context, state) {
                    if (state is WeatherLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(22.r),
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        weatherBloc.add(
                          GetWeatherInfoEvent(location: _controller.text),
                        );
                      },
                      child: Text(
                        "Поиск",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
                hintText: "Введите название города",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
