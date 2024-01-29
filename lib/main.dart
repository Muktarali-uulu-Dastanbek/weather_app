import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/presentation/screens/search_location_screen.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/internal/helpers/localization/bloc/global_localization_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? locale;
  GlobalLocalizationBloc bloc = GlobalLocalizationBloc();

  @override
  void initState() {
    localeHelper();
    super.initState();
  }

  localeHelper() async {
    String locale = await getCurrentLocale();
    bloc.add(ChangeLocalEvent(locale: locale));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale.fromSubtags(languageCode: locale ?? "ru"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BlocListener<GlobalLocalizationBloc, GlobalLocalizationState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is GlobalLocalizationLadedState) {
                locale = state.locale;
              }
            },
            child: SearchLocationScreen(),
          ),
        );
      },
    );
  }
}
