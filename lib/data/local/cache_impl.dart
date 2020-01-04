import 'package:state_management/data/model/movie_entity.dart';

abstract class Cache {
  void setMovies(List<MovieEntity> movies);

  List<MovieEntity> getMovies();

  void clearMovies();

  void clear();
}
