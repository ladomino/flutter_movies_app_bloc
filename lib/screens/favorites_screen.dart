import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_bloc/constants/my_app_icons.dart';
import 'package:movies_app_bloc/models/movies_model.dart';
import 'package:movies_app_bloc/service/init_getit.dart';
import 'package:movies_app_bloc/view_model/favorites/favorites_bloc.dart';
import 'package:movies_app_bloc/widgets/my_error_widget.dart';
import 'package:movies_app_bloc/widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Favorite Movies"),
      actions: [
        IconButton(
          onPressed: () => getIt<FavoritesBloc>().add(RemoveAllFromFavorites()),
          icon: const Icon(MyAppIcons.delete, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return state.when(
          loading:
              () => const Center(child: CircularProgressIndicator.adaptive()),
          error:
              (message) => MyErrorWidget(
                errorText: message,
                retryFunction:
                    () => getIt<FavoritesBloc>().add(LoadFavorites()),
              ),
          loaded: (favorites) => _buildFavoritesList(favorites),
          initial: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildFavoritesList(List<MovieModel> favorites) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          "No Favorites have been added yet",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder:
          (context, index) => MoviesWidget(movieModel: favorites[index]),
    );
  }
}
