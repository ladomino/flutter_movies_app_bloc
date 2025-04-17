import 'package:movies_app_bloc/models/movies_genre.dart';
import 'package:movies_app_bloc/models/movies_model.dart';
import 'package:movies_app_bloc/service/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  
  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  // List<MoviesGenre> cachedGenres = [];
  Future<List<MoviesGenre>> fetchGenres() async {
    // return cachedGenres = await _apiService.fetchGenres();
    return await _apiService.fetchGenres();
  }
}