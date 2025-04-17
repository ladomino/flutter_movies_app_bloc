import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_bloc/models/movies_genre.dart';
import 'package:movies_app_bloc/models/movies_model.dart';
import 'package:movies_app_bloc/utils/genre_utils.dart';
import 'package:movies_app_bloc/view_model/movies/movies_bloc.dart';

class GenresListWidget extends StatelessWidget {
  final MovieModel movieModel;

  const GenresListWidget({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {

        if (state is MoviesLoadedState || state is MoviesLoadingMoreState) {

          List<MoviesGenre> moviesGenre = GenreUtils.movieGenresNames(
              movieModel.genreIds,
              state is MoviesLoadedState
                  ? state.genres
                  : (state as MoviesLoadingMoreState).genres);

          return Wrap(
            children: List.generate(
              moviesGenre.length,
              (index) => chipWidget(
                  genreName: moviesGenre[index].name, context: context),
            ),
          );
        }
        return const Text("Loading genres...");
      },
    );
  }

  Widget chipWidget(
      {required String genreName, required BuildContext context}) {
        
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Text(
            genreName,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
          ),
        ),
      ),
    );
  }
}