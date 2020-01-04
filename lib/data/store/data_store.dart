import 'package:state_management/data/model/movie_entity.dart';

abstract class DataStore {
  Future<List<MovieEntity>> getMovies();

  Future<MovieEntity> getMovie(String title);
}
