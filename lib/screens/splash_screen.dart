import 'package:flutter/material.dart';

import 'package:movies_app_provider/screens/movies_screen.dart';
import 'package:movies_app_provider/service/init_getit.dart';
import 'package:movies_app_provider/service/navigation_service.dart';
import 'package:movies_app_provider/view_model/favorites_provider.dart';
import 'package:movies_app_provider/view_model/movies_provider.dart';
import 'package:movies_app_provider/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Cleaner style 

  // Future<void> _loadInitialData(BuildContext context) async {
  //   if (!context.mounted) return;

  //   final favoritesProvider = Provider.of<FavoritesProvider>(
  //     context,
  //     listen: false,
  //   );
  //   final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

  //   try {
  //     await Future.wait([
  //       favoritesProvider.loadFavorites(),
  //       moviesProvider.getMovies(),
  //     ]);
  //   } catch (e) {
  //     // Handle any errors that occurred during loading
  //     // print('Error loading initial data: $e');
  //     // You might want to rethrow the error or handle it in some way
  //     rethrow;
  //   }
  // }

  Future<void> _loadInitialData(BuildContext context) async {
    await Future.microtask(() async {
      if (!context.mounted) return;

      await Provider.of<FavoritesProvider>(
        context,
        listen: false,
      ).loadFavorites();

      if (!context.mounted) return;

      await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    // });
  }

  // Many ways to improve this for error handling when Futures fail and what you 
  // will display.
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.hasError) {
            if (moviesProvider.genresList.isNotEmpty) {

              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>().navigateReplace(
                  const MoviesScreen(),
                );

              });
            }
            return Provider.of<MoviesProvider>(context).isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : MyErrorWidget(
                  errorText: snapshot.error.toString(),
                  retryFunction: () async {
                    await _loadInitialData(context);
                  },
                );
          } else {

            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(const MoviesScreen());
              
            });

            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
