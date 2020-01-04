import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final String _title;
  final String _imageUrl;
  final bool _isGrid;
  final GestureTapCallback _onTap;
  final double _rating;
  final String _genre;
  final int _year;

  MovieItem.grid(
      {@required String title,
      @required String imageUrl,
      @required GestureTapCallback onTap})
      : this._title = title,
        this._imageUrl = imageUrl,
        this._isGrid = true,
        this._onTap = onTap,
        this._rating = null,
        this._genre = null,
        this._year = null;

  MovieItem.list(
      {@required String title,
      @required String imageUrl,
      @required double rating,
      @required String genre,
      @required int year,
      @required GestureTapCallback onTap})
      : this._title = title,
        this._imageUrl = imageUrl,
        this._rating = rating,
        this._genre = genre,
        this._year = year,
        this._isGrid = false,
        this._onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return this._isGrid
        ? this._buildGridItem(context)
        : this._buildListItem(context);
  }

  Widget _buildListItem(BuildContext context) {
    return Stack(children: [
      Card(
        elevation: 6.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                this._imageUrl,
                fit: BoxFit.cover,
                width: 80.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this._title,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Rating: ${this._rating}',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned.fill(
          child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: this._onTap,
        ),
      ))
    ]);
  }

  Widget _buildGridItem(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              this._imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 50.0,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  this._title,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),
                ),
              )),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: this._onTap,
            ),
          ))
        ],
      ),
    );
  }
}
