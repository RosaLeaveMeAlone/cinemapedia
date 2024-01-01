import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  
  final List<Movie> movies;
  final String? label;
  final String? sublabel;

  final VoidCallback? loadNextPage;
  
  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.label, 
    this.sublabel, 
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(label != null || sublabel != null)
            _Title(label: label,sublabel: sublabel,),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  
  final String? label;
  final String? sublabel;
  
  const _Title({super.key, this.label, this.sublabel});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;


    return Container(
      padding: const EdgeInsets.only(top:10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if(label != null)
            Text(label!, style: titleStyle),
          const Spacer(),
          if(sublabel != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){},
              child: Text(sublabel!),
            ),
        ],
      ),
    );
  }
}