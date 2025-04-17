part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(String message) error,
    required T Function(List<MovieModel> favorites) loaded,
  }) {
    return switch (this) {
      FavoritesInitial() => initial(),
      FavoritesLoading() => loading(),
      FavoritesError(message: var message) => error(message),
      FavoritesLoaded(favorites: var favorites) => loaded(favorites),
    };
  }
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<MovieModel> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});
  @override
  List<Object> get props => [message];
}
