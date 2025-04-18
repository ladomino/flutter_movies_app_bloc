import 'package:get_it/get_it.dart';
import 'package:movies_app_bloc/repository/movies_repo.dart';
import 'package:movies_app_bloc/service/api_service.dart';
import 'package:movies_app_bloc/service/navigation_service.dart';
import 'package:movies_app_bloc/view_model/favorites/favorites_bloc.dart';
import 'package:movies_app_bloc/view_model/movies/movies_bloc.dart';
import 'package:movies_app_bloc/view_model/theme/theme_bloc.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt<ApiService>()));

  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<MoviesBloc>(() => MoviesBloc());
  getIt.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc());
}

Future<void> closeLocator() async {
  // Dispose of resources that need explicit cleanup
  await getIt<FavoritesBloc>().close();
  await getIt<MoviesBloc>().close();
  await getIt<ThemeBloc>().close();
  await getIt<FavoritesBloc>().close();

  // Reset the entire GetIt instance
  await getIt.reset();
}