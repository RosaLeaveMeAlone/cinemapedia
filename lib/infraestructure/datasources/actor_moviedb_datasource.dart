



import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/config/domain/datasources/actor_datasource.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

    final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key' : Enviroment.movieDbKey,
      'language' : 'es-ES',
    }
    
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
      final response = await dio.get('/movie/$movieId/credits');

    if( response.statusCode != 200) throw Exception('Cast with id: $movieId not found');

    final castResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
      ).toList();
    return actors;

  }

}