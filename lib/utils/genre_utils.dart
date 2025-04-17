import 'package:flutter/material.dart';
import 'package:movies_app_provider/models/movies_genre.dart';
import 'package:movies_app_provider/view_model/movies_provider.dart';
import 'package:provider/provider.dart';

class GenreUtils {
  
  static List<MoviesGenre> movieGenresNames(
    List<int> genreIds,
    BuildContext context,
  ) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    // final moviesRepository = getIt<MoviesRepository>(); // Not used anymore
    // Get the Genres using the movies provider
    final cachedGenres = moviesProvider.genresList;
    List<MoviesGenre> genresNames = [];

    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }

    return genresNames;
  }
}
