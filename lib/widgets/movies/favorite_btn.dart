import 'package:flutter/material.dart';
import 'package:movies_app_provider/constants/my_app_icons.dart';
import 'package:movies_app_provider/models/movies_model.dart';
import 'package:movies_app_provider/view_model/favorites_provider.dart';
import 'package:provider/provider.dart';


class FavoriteBtnWidget extends StatelessWidget {
  final MovieModel movieModel;
  
  const FavoriteBtnWidget({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
      final FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context);

      return IconButton(
        onPressed: () {
          favoritesProvider.addOrRemoveFromFavorites(movieModel);
        },
        icon: Icon(
           favoritesProvider.isFavorite(movieModel)
              ? MyAppIcons.favoriteRounded
              : MyAppIcons.favoriteOutlineRounded,
          color: favoritesProvider.isFavorite(movieModel) ? Colors.red : null,
          size: 20,
        ),
      );
    }
}