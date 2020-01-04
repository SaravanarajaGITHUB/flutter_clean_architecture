import 'package:state_management/domain/model/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies();
  Future<Movie> getMovie(String title);
}
