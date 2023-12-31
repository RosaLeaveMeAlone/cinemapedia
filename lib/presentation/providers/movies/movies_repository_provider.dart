



import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/movie_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Read Only / Inmutable
final movieRepositoryProvider = Provider((ref) {


  return MovieRepositoryImp(MoviedbDatasource());
});