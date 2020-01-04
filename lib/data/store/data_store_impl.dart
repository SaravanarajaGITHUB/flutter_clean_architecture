import 'package:state_management/data/model/movie_entity.dart';
import 'package:state_management/data/service/web_service.dart';
import 'package:state_management/data/store/data_store.dart';

class DataStoreImpl implements DataStore {
  final WebService _service;

  DataStoreImpl(this._service);

  @override
  Future<List<MovieEntity>> getMovies() async {
    final response = await this._service.getMoviesResponse();
    return response.map((movie) => MovieEntity.fromJson(movie)).toList();
  }
}
