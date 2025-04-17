import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app_bloc/screens/splash_screen.dart';
import 'package:movies_app_bloc/service/init_getit.dart';
import 'package:movies_app_bloc/service/navigation_service.dart';
import 'package:movies_app_bloc/view_model/favorites/favorites_bloc.dart';
import 'package:movies_app_bloc/view_model/movies/movies_bloc.dart';
import 'package:movies_app_bloc/view_model/theme/theme_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator(); // Initialize GetIt

  // Lock the orientation and load the .env file and keys
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) async {

    await dotenv.load(fileName: "assets/.env");

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Initialize Blocs
    final themeBloc = getIt<ThemeBloc>()..add(LoadThemeEvent());
    final moviesBloc = getIt<MoviesBloc>();
    final favoritesBloc = getIt<FavoritesBloc>();


    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<MoviesBloc>.value(value: moviesBloc),
        BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState> 
          (builder: (context, state) {

          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies Flutter App',
            theme: state is LightThemeState ? ThemeData.light() : ThemeData.dark(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
