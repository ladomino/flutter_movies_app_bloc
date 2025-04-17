import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app_provider/screens/splash_screen.dart';
import 'package:movies_app_provider/service/init_getit.dart';
import 'package:movies_app_provider/service/navigation_service.dart';
import 'package:movies_app_provider/view_model/favorites_provider.dart';
import 'package:movies_app_provider/view_model/movies_provider.dart';
import 'package:movies_app_provider/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(), //..loadTheme(),
        ),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: Consumer(builder: (context, ThemeProvider themeProvider, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies Flutter App',
            theme: themeProvider.themeData,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
