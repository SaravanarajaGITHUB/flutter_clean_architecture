import 'package:state_management/data/local/cache_impl.dart';
import 'package:state_management/data/model/movie_entity.dart';
import 'package:state_management/data/remote/web_service.dart';
import 'package:state_management/data/store/data_store.dart';

class DataStoreImpl implements DataStore {
  final WebService _service;
  final Cache _cache;

  DataStoreImpl(this._service, this._cache);

  @override
  Future<List<MovieEntity>> getMovies() async {
    if (this._cache.getMovies() == null || this._cache.getMovies().isEmpty) {
      final response = await this._service.getMoviesResponse();
      final movies =
          response.map((movie) => MovieEntity.fromJson(movie)).toList();
      this._cache.setMovies(movies);
    }
    return this._cache.getMovies();
  }

  @override
  Future<MovieEntity> getMovie(String title) async {
    final movies = await getMovies();
    return movies.where((it) => it.title == title).first;
  }
}
