


import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key' : Enviroment.movieDbKey,
      'language' : 'es-ES',
    }
    
  ));



  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing',
    queryParameters: {
      'page': page
    }
    );
    final movieDBResponde = MovieDbResponse.fromJson(response.data);
    final List<Movie> filteredMovies = [];
    
    final List<Movie> movies = movieDBResponde.results
    //! La linea de abajo por algun motivo no estaba filtrando, investigar porque no funciona
    // .where((movieDb) => movieDb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
      ).toList();


    for (Movie movie in movies) {
      if (movie.posterPath != 'no-poster' && _isValidUrl(movie.posterPath)) {
        filteredMovies.add(movie);
      }
    }


    return filteredMovies;
  }

  bool _isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

}