import 'package:state_management/data/remote/app_exception.dart';
import 'package:state_management/domain/model/movie.dart';
import 'package:state_management/domain/utils/domain_constants.dart';
import 'package:state_management/ui/model/movie_model.dart';

class DomainToModelMapper {
  List<MovieModel> transformMovies(List<Movie> movieEntities) {
    return movieEntities
        .map((movieEntity) => this.transformMovie(movieEntity))
        .toList();
  }

  MovieModel transformMovie(Movie movieEntity) {
    return MovieModel(
        title: movieEntity.title,
        image: movieEntity.image,
        releaseYear: movieEntity.releaseYear,
        rating: movieEntity.rating,
        genre: this._transformGenreList(movieEntity.genre));
  }

  List<String> _transformGenreList(List<Genre> genres) {
    return genres.map((genre) => this._transformGenre(genre)).toList();
  }

  String _transformGenre(Genre genre) {
    switch (genre) {
      case Genre.ACTION:
        return DomainConstants.ACTION;
      case Genre.DRAMA:
        return DomainConstants.DRAMA;
      case Genre.SCI_FI:
        return DomainConstants.SCI_FI;
      case Genre.THRILLER:
        return DomainConstants.THRILLER;
      case Genre.ADVENTURE:
        return DomainConstants.ADVENTURE;
      case Genre.HISTORY:
        return DomainConstants.HISTORY;
      case Genre.FANTASY:
        return DomainConstants.FANTASY;
      case Genre.ANIMATION:
        return DomainConstants.ANIMATION;
      case Genre.COMEDY:
        return DomainConstants.COMEDY;
      case Genre.FAMILY:
        return DomainConstants.FAMILY;
      case Genre.HORROR:
        return DomainConstants.HORROR;
      case Genre.CRIME:
        return DomainConstants.CRIME;
    }
    throw InvalidInputException('Invalid genre');
  }
}
