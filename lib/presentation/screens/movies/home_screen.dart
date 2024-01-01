
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {


  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();


  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlidesshowProvider);

    if(slideShowMovies.length == 0) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomScrollView(

      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppbar(),
          )
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                      children: [
                        // const CustomAppbar(),
                        MoviesSlideshow(movies: slideShowMovies),
                    
                        MovieHorizontalListview(
                          movies: nowPlayingMovies,
                          label: 'En cines',
                          sublabel: 'Hoy',
                          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                          ),
                        MovieHorizontalListview(
                          movies: nowPlayingMovies,
                          label: 'Proximamente',
                          sublabel: 'En este mes',
                          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                          ),
                        MovieHorizontalListview(
                          movies: nowPlayingMovies,
                          label: 'Populares',
                          // sublabel: 'En este mes',
                          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                          ),
                        MovieHorizontalListview(
                          movies: nowPlayingMovies,
                          label: 'Mejor Calificadas',
                          sublabel: 'Desde siempre',
                          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                          ),
                        SizedBox(height: 10,)
                      ],
                    );
            },
            childCount: 1
          )
        )



      ],
    );
  }
}