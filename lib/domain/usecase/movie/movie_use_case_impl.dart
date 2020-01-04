import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/domain/model/response.dart';
import 'package:state_management/domain/usecase/movie_use_case.dart';
import 'package:state_management/domain/utils/domain_to_model_mapper.dart';
import 'package:state_management/ui/model/movie_model.dart';

class MovieUseCaseImpl implements MovieUseCase {
  final MovieRepository _movieRepository;
  final DomainToModelMapper _domainToModelMapper;

  MovieUseCaseImpl(this._movieRepository, this._domainToModelMapper);

  @override
  Future<Response<List<MovieModel>>> getMovies() async {
    try {
      final movies = await this._movieRepository.getMovies();
      return Response.completed(
          data: this._domainToModelMapper.transformMovies(movies));
    } catch (e) {
      return Response.error(message: e.toString());
    }
  }
}
