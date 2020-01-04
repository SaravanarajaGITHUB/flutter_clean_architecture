import 'package:flutter/foundation.dart';
import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/data/service/api_response.dart';
import 'package:state_management/domain/model/movie.dart';
import 'package:state_management/view_model/base_view_model.dart';
import 'package:state_management/view_model/view_state.dart';

class MovieListViewModel extends BaseViewModel {
  bool _isGrid = true;
  bool _animateList = true;
  ApiResponse<List<Movie>> _movies;
  final MovieRepository _movieRepo;

  MovieListViewModel(this._movieRepo);

  bool get isGrid => this._isGrid;

  ApiResponse<List<Movie>> get movies => this._movies;

  set animateList(bool animateList) => this._animateList = animateList;

  bool get animateList => this._animateList;

  Future<void> getMovies() async {
    setState(ViewState.BUSY);
    try {
      final movies = await this._movieRepo.getMovies();
      this._movies = ApiResponse.completed(data: movies);
    } catch (e) {
      this._movies = ApiResponse.error(message: e.toString());
      debugPrint(e.toString());
    }
    setState(ViewState.IDLE);
  }

  void changeGridStatus() {
    this._isGrid = !_isGrid;
    this._animateList = true;
    setState(ViewState.IDLE);
  }
}
