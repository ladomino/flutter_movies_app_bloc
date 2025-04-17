import 'package:movies_app_bloc/models/movies_genre.dart';

class GenreUtils {
  
  static List<MoviesGenre> movieGenresNames(
    List<int> genreIds,
    List<MoviesGenre> allGenresList
  ) {
  
    List<MoviesGenre> genresNames = [];

    for (var genreId in genreIds) {
      var genre = allGenresList.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }

    return genresNames;
  }
}
