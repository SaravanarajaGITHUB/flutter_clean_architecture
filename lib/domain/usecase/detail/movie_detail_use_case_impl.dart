import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/domain/model/response.dart';
import 'package:state_management/domain/usecase/detail/movie_detail_use_case.dart';
import 'package:state_management/domain/utils/domain_to_model_mapper.dart';
import 'package:state_management/ui/model/movie_model.dart';

class MovieDetailUseCaseImpl extends MovieDetailUseCase {
  final MovieRepository _movieRepository;
  final DomainToModelMapper _domainToModelMapper;

  MovieDetailUseCaseImpl(this._movieRepository, this._domainToModelMapper);

  @override
  Future<Response<MovieModel>> getMovie(String title) async {
    try {
      final movie = await this._movieRepository.getMovie(title);
      return Response.completed(
          data: this._domainToModelMapper.transformMovie(movie));
    } catch (e) {
      return Response.error(message: e.toString());
    }
  }
}
