import 'package:state_management/domain/model/response.dart';
import 'package:state_management/ui/model/movie_model.dart';

abstract class MovieDetailUseCase{
  Future<Response<MovieModel>> getMovie(String title);
}