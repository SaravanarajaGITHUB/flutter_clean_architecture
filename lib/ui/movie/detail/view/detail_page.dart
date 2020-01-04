import 'package:flutter/material.dart';
import 'package:state_management/domain/model/movie.dart';
import 'package:state_management/ui/movie/detail/view_model/detail_view_model.dart';
import 'package:state_management/view_model/base_view.dart';

class DetailPage extends StatelessWidget {
  static const route_name = '/detail';

  final Movie _movie;

  DetailPage(this._movie);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(
      builder: (buildContext, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Movie Detail'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: this._movie.image,
                      child: Image.network(
                        this._movie.image,
                        fit: BoxFit.cover,
                        width: 120.0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this._movie.title,
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                            this._buildText(
                                context, 8.0, 'Rating: ${this._movie.rating}'),
                            this._buildText(context, 4.0,
                                'Year: ${this._movie.releaseYear}'),
                            this._buildText(
                                context, 4.0, '${this._movie.genre}')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                this._buildText(context, 16.0,
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, double topPadding, String text) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.subtitle.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
