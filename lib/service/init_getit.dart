import 'package:get_it/get_it.dart';
import 'package:movies_app_provider/repository/movies_repo.dart';
import 'package:movies_app_provider/service/api_service.dart';
import 'package:movies_app_provider/service/navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt<ApiService>()));
}