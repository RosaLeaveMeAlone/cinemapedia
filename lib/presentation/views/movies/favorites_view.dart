import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView.builder(
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text('Movie $index'),
  //         );
  //       }
  //       ),
  //   );
  // }
  
  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {


    final Map<int, Movie> favorites = ref.watch(favoriteMoviesProvider);

    final List<MapEntry<int, Movie>> favoriteList = favorites.entries.toList();

    return ListView.builder(
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        final movie = favoriteList[index].value;
        return ListTile(
          title: Text(movie.title),
        );
      }
    );
  }

  
}