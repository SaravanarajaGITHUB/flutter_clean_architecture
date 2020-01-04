import 'package:flutter/material.dart';
import 'package:state_management/domain/model/response.dart';
import 'package:state_management/ui/helper/base_view.dart';
import 'package:state_management/ui/helper/view_state.dart';
import 'package:state_management/ui/movie/detail/view_model/detail_view_model.dart';
import 'package:state_management/ui/utils/presentation_constants.dart';

class DetailPage extends StatelessWidget {
  static const route_name = '/detail';

  final String _title;

  DetailPage(this._title);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(
      onModelReady: (model) => model.getMovie(this._title),
      builder: (buildContext, model, widget) =>
          Scaffold(
            appBar: AppBar(
              title: Text(PresentationConstants.MOVIE_DETAIL),
            ),
            body: ViewState.BUSY == model.state
                ? this._buildBusyWidget()
                : Status.COMPLETED == model.movie.status
                ? SingleChildScrollView(
              child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: model.movie.data.image,
                          child: Image.network(
                            model.movie.data.image,
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
                                  model.movie.data.title,
                                  textAlign: TextAlign.start,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                this._buildText(context, 8.0,
                                    '${PresentationConstants.RATING} ${model.movie.data.rating}'),
                                this._buildText(context, 4.0,
                                    '${PresentationConstants.YEAR} ${model.movie.data.releaseYear}'),
                                this._buildText(
                                    context, 4.0, '${model.movie.data.genre}')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    this._buildText(context, 16.0,
                        PresentationConstants.MOCK_MOVIE_DETAIL)
                  ],
                ),
              ),
            ):this._buildErrorWidget(context, model.movie.message),
          ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Theme.of(context).primaryColor,
            size: 72.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, double topPadding, String text) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme
            .of(context)
            .textTheme
            .subtitle
            .copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildBusyWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
