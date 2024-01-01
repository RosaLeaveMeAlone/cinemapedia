import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  
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
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }

    });
    
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.label != null || widget.sublabel != null)
            _Title(label: widget.label,sublabel: widget.sublabel,),
          

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slide(
                    movie: widget.movies[index],
                  ),
                );
              },
            )
          ),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2,)
                      )
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          SizedBox(height: 5,),


          //* Titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating

          Row(
            children: [
              Icon(Icons.star_half_outlined, size: 15, color: Colors.yellow.shade800,),
              const SizedBox(width: 5,),
              Text(
                '${movie.voteAverage}',
                style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(width: 3,),
              Text(
                '(${ HumanFormats.number(movie.popularity)})',
                // '(${movie.popularity})',
                style: textStyles.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),

          ]
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