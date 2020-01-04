import 'package:state_management/data/model/movie_entity.dart';
import 'package:state_management/data/service/app_exception.dart';
import 'package:state_management/data/utils/data_constants.dart';
import 'package:state_management/domain/model/movie.dart';
import 'package:state_management/domain/utils/domain_constants.dart';

class DataToDomainMapper {
  List<Movie> transformMovies(List<MovieEntity> movieEntities) {
    return movieEntities
        .map((movieEntity) => this._transformMovie(movieEntity))
        .toList();
  }

  Movie _transformMovie(MovieEntity movieEntity) {
    return Movie(
        title: movieEntity.title,
        image: movieEntity.image,
        releaseYear: movieEntity.releaseYear,
        rating: movieEntity.rating,
        genre: this._transformGenreList(movieEntity.genre));
  }

  List<Genre> _transformGenreList(List<String> genres) {
    return genres.map((genre) => this._transformGenre(genre)).toList();
  }

  Genre _transformGenre(String genre) {
    switch (genre) {
      case DataConstants.ACTION:
        return Genre.ACTION;
      case DataConstants.DRAMA:
        return Genre.DRAMA;
      case DataConstants.SCI_FI:
        return Genre.SCI_FI;
      case DataConstants.THRILLER:
        return Genre.THRILLER;
      case DataConstants.ADVENTURE:
        return Genre.ADVENTURE;
      case DataConstants.HISTORY:
        return Genre.HISTORY;
      case DataConstants.FANTASY:
        return Genre.FANTASY;
      case DataConstants.ANIMATION:
        return Genre.ANIMATION;
      case DataConstants.COMEDY:
        return Genre.COMEDY;
      case DataConstants.FAMILY:
        return Genre.FAMILY;
      case DataConstants.HORROR:
        return Genre.HORROR;
      case DataConstants.CRIME:
        return Genre.CRIME;
    }
    throw InvalidInputException('Invalid genre');
  }
}
