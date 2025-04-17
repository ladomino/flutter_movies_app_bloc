import 'package:flutter/material.dart';
import 'package:movies_app_provider/view_model/favorites_provider.dart';
import 'package:provider/provider.dart';

import '../constants/my_app_icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              favoritesProvider.clearAllFavs();
            },
            icon: const Icon(MyAppIcons.delete, color: Colors.red),
          ),
        ],
      ),
      body:
          favoritesProvider.favoritesList.isEmpty
              ? const Center(
                child: Text(
                  "No added Favs",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: favoritesProvider.favoritesList.length,
                itemBuilder: (context, index) {
                  final favMovie =
                      favoritesProvider.favoritesList.reversed.toList()[index];

                  return (MoviesWidget(
                    movieModel: favMovie,
                  )); //const Text("data");
                },
              ),
    );
  }
}
