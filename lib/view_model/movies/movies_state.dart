part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(String message) error,
    required T Function(List<MovieModel> movies, List<MoviesGenre> genres, int currentPage) loaded,
    required T Function(List<MovieModel> movies, List<MoviesGenre> genres, int currentPage) loadingMore,
  }) {
    return switch (this) {
      MoviesInitial() => initial(),
      MoviesLoadingState() => loading(),
        MoviesErrorState(message: var message) => error(message),
      MoviesLoadedState(movies: var movies, genres: var genres, currentPage: var currentPage) => 
        loaded(movies, genres, currentPage),
      MoviesLoadingMoreState(movies: var movies, genres: var genres, currentPage: var currentPage) => 
        loadingMore(movies, genres, currentPage),
    };
  }
  
  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoadingState extends MoviesState {}

final class MoviesLoadedState extends MoviesState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  const MoviesLoadedState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });

  @override
  List<Object> get props => [movies, genres, currentPage];
}

final class MoviesLoadingMoreState extends MoviesState { 
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  const MoviesLoadingMoreState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });
  @override
  List<Object> get props => [movies, genres, currentPage];
}

final class MoviesErrorState extends MoviesState {
  final String message;

  const MoviesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}