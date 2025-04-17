import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_bloc/constants/my_app_icons.dart';
import 'package:movies_app_bloc/models/movies_model.dart';
import 'package:movies_app_bloc/screens/favorites_screen.dart';
import 'package:movies_app_bloc/service/init_getit.dart';
import 'package:movies_app_bloc/service/navigation_service.dart';
import 'package:movies_app_bloc/view_model/movies/movies_bloc.dart';
import 'package:movies_app_bloc/view_model/theme/theme_bloc.dart';
import 'package:movies_app_bloc/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), 
      body: _buildBody()
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Popular Movies"),
      actions: [
        _buildFavoritesButton(), 
        _buildThemeToggleButton()
      ],
    );
  }

  Widget _buildFavoritesButton() {
    return IconButton(
      onPressed:
          () => getIt<NavigationService>().navigate(const FavoritesScreen()),
      icon: const Icon(MyAppIcons.favoriteRounded, color: Colors.red),
    );
  }

  Widget _buildThemeToggleButton() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => getIt<ThemeBloc>().add(ToggleThemeEvent()),
          icon: Icon(
            state is DarkThemeState
                ? MyAppIcons.darkMode
                : MyAppIcons.lightMode,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        return state.when(
        initial: () => const Center(child: Text('Initializing...')),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (message) => Center(child: Text(message)),
        loaded: (movies, genres, currentPage) => _buildMoviesList(movies, false),
        loadingMore: (movies, genres, currentPage) => _buildMoviesList(movies, true),
        );
      },
    );
  }

  Widget _buildMoviesList(List<MovieModel> movies, bool isLoadingMore) {

    return NotificationListener<ScrollNotification>(
      onNotification:
          (scrollInfo) => _handleScrollNotification(scrollInfo, isLoadingMore),
      child: ListView.builder(
        itemCount: isLoadingMore ? movies.length + 1 : movies.length,
        itemBuilder: (context, index) {
          if (index >= movies.length && isLoadingMore) {
            return const _LoadingIndicator();
          }
          return MoviesWidget(movieModel: movies[index]);
        },
      ),
    );
  }

  bool _handleScrollNotification(
    ScrollNotification scrollInfo,
    bool isLoadingMore,
  ) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        !isLoadingMore) {
      getIt<MoviesBloc>().add(FetchMoreMoviesEvent());
      return true;
    }
    return false;
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
