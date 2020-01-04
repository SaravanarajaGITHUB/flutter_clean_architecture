import 'package:state_management/data/local/cache_impl.dart';
import 'package:state_management/data/model/movie_entity.dart';

class CacheImpl implements Cache {
  List<MovieEntity> _movies;

  @override
  List<MovieEntity> getMovies() {
    return this._movies;
  }

  @override
  void setMovies(List<MovieEntity> movies) {
    this._movies = movies;
  }

  @override
  void clearMovies() {
    this._movies = null;
  }

  @override
  void clear() {
    this.clearMovies();
  }
}
