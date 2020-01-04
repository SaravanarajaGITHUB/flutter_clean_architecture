import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:state_management/data/service/api_response.dart';
import 'package:state_management/domain/model/movie.dart';
import 'package:state_management/state_view.dart';
import 'package:state_management/ui/movie/detail/view/detail_page.dart';
import 'package:state_management/ui/movie/list/view/movie_item.dart';
import 'package:state_management/ui/movie/list/view_model/movie_list_view_model.dart';
import 'package:state_management/view_model/base_view.dart';

class MovieListPage extends StatelessWidget {
  static const routeName = '/';
  final Key _uniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BaseView<MovieListViewModel>(
      onModelReady: (model) => model.getMovies(),
      builder: (buildContext, model, widget) => Scaffold(
          appBar: AppBar(
            title: Text('Movies'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(model.isGrid ? Icons.grid_on : Icons.list),
                  onPressed: () => model.changeGridStatus())
            ],
          ),
          body: StateView(
            viewState: model.state,
            onBusy: this._buildBusyWidget(),
            onIdle: Status.COMPLETED == model.movies.status
                ? AnimationLimiter(
                    key: this._createUniqueKey(model),
                    child: model.isGrid
                        ? GridView.builder(
                            itemCount: model.movies.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                            ),
                            padding: EdgeInsets.all(8.0),
                            shrinkWrap: true,
                            itemBuilder: (buildContext, index) =>
                                AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: Duration(milliseconds: 375),
                                  delay: Duration(milliseconds: 325),
                                  child: ScaleAnimation(
                                    scale: 0.5,
                                    child: FadeInAnimation(
                                      child: this._itemBuilder(
                                          context,
                                          model.movies.data[index],
                                          model.isGrid),
                                    ),
                                  ),
                                ))
                        : ListView.builder(
                            itemCount: model.movies.data.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12.0),
                            itemBuilder: (buildContext, index) =>
                                AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 375),
                                  delay: Duration(milliseconds: 325),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: this._itemBuilder(
                                          context,
                                          model.movies.data[index],
                                          model.isGrid),
                                    ),
                                  ),
                                )))
                : this._buildErrorWidget(context, model.movies.message),
          )),
    );
  }

  Widget _buildBusyWidget() {
    return Center(child: CircularProgressIndicator());
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

  Widget _itemBuilder(BuildContext context, Movie movie, bool isGrid) => Hero(
        tag: movie.image,
        child: isGrid
            ? MovieItem.grid(
                title: movie.title,
                imageUrl: movie.image,
                onTap: () => Navigator.of(context)
                    .pushNamed(DetailPage.route_name, arguments: movie),
              )
            : MovieItem.list(
                title: movie.title,
                imageUrl: movie.image,
                genre: movie.genre.toString(),
                rating: movie.rating,
                year: movie.releaseYear,
                onTap: () => Navigator.of(context)
                    .pushNamed(DetailPage.route_name, arguments: movie),
              ),
      );

  UniqueKey _createUniqueKey(MovieListViewModel listViewModel) {
    final uniqueKey = listViewModel.animateList ? UniqueKey() : this._uniqueKey;
    listViewModel.animateList = false;
    return uniqueKey;
  }
}
