import 'package:flutter/material.dart';

import 'package:movies_app_provider/constants/my_app_icons.dart';
import 'package:movies_app_provider/models/movies_model.dart';
import 'package:movies_app_provider/screens/movie_details.dart';
import 'package:movies_app_provider/service/init_getit.dart';
import 'package:movies_app_provider/service/navigation_service.dart';
import 'package:movies_app_provider/widgets/cached_image.dart';
import 'package:movies_app_provider/widgets/movies/favorite_btn.dart';
import 'package:movies_app_provider/widgets/movies/genres_list_widget.dart';


class MoviesWidget extends StatelessWidget {
  final MovieModel movieModel;
  
  const MoviesWidget({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigate(
                MovieDetailsScreen(movieModel: movieModel),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedImageWidget(
                       imgUrl:
                            "https://image.tmdb.org/t/p/w500/${movieModel.backdropPath}",
                      ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel.originalTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text(
                                "${movieModel.voteAverage.toStringAsFixed(1)}/10"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(movieModel: movieModel,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              movieModel.releaseDate,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(
                              movieModel: movieModel,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
