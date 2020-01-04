import 'package:flutter/foundation.dart';
import 'package:state_management/domain/utils/domain_constants.dart';

class Movie {
  final String _title;
  final String _image;
  final double _rating;
  final int _releaseYear;
  final List<Genre> _genre;

  Movie(
      {@required String title,
      @required String image,
      @required double rating,
      @required int releaseYear,
      @required List<Genre> genre})
      : this._title = title,
        this._image = image,
        this._rating = rating,
        this._releaseYear = releaseYear,
        this._genre = genre;

  String get title => this._title;

  String get image => this._image;

  double get rating => this._rating;

  int get releaseYear => this._releaseYear;

  List<Genre> get genre => this._genre;
}
