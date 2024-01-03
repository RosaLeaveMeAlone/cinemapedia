


import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);



class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});


  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(onPressed: () => query = '', 
        icon: const Icon(Icons.clear)
        )
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    

    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    

    return const Text('Build Results');

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    

    return FutureBuilder(
      future: searchMovies(query), 
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];


        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: close,),
        );
      },
      );
  }

}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context,movie);
      
      },//() => Navigator.pushNamed(context, '/movie', arguments: movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                  ),
              ),
            ),
      
            const SizedBox(width: 10),
      
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length < 100)
                  ? Text(movie.overview, style: textStyle.bodyMedium)
                  : Text('${movie.overview.substring(0, 100)}...', style: textStyle.bodyMedium),
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                      SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1), 
                        style: textStyle.bodySmall!.copyWith(color: Colors.yellow.shade900)
                      ),
                    ],
                  )
      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}