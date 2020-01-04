class MovieEntity {
  String _title;
  String _image;
  double _rating;
  int _releaseYear;
  List<String> _genre;

  String get title => _title;

  String get image => _image;

  double get rating => _rating;

  int get releaseYear => _releaseYear;

  List<String> get genre => _genre;

  MovieEntity.fromJson(Map<String, dynamic> json) {
    this._title = json['title'];
    this._image = json['image'];
    this._rating = double.tryParse(json['rating'].toString());
    this._releaseYear = json['releaseYear'];
    this._genre = json['genre'].cast<String>();
  }
}
