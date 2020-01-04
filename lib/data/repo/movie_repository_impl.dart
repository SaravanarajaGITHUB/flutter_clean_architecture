import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/data/store/data_store.dart';
import 'package:state_management/data/utils/data_to_domain_mapper.dart';
import 'package:state_management/domain/model/movie.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DataStore _dataStore;
  final DataToDomainMapper _dataToDomainMapper;

  MovieRepositoryImpl(this._dataStore, this._dataToDomainMapper);

  @override
  Future<List<Movie>> getMovies() async {
    final movieEntities = await this._dataStore.getMovies();
    return this._dataToDomainMapper.transformMovies(movieEntities);
  }

  @override
  Future<Movie> getMovie(String title) async {
    final movieEntity = await this._dataStore.getMovie(title);
    return this._dataToDomainMapper.transformMovie(movieEntity);
  }
}
