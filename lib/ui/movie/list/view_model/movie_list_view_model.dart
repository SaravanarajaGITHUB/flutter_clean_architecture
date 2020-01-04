import 'package:state_management/domain/model/response.dart';
import 'package:state_management/domain/usecase/movie/movie_use_case.dart';
import 'package:state_management/ui/helper/base_view_model.dart';
import 'package:state_management/ui/helper/view_state.dart';
import 'package:state_management/ui/model/movie_model.dart';

class MovieListViewModel extends BaseViewModel {
  bool _isGrid = true;
  bool _animateList = true;
  Response<List<MovieModel>> _movies;
  final MovieUseCase _movieUseCase;

  MovieListViewModel(this._movieUseCase);

  bool get isGrid => this._isGrid;

  Response<List<MovieModel>> get movies => this._movies;

  set animateList(bool animateList) => this._animateList = animateList;

  bool get animateList => this._animateList;

  Future<void> getMovies() async {
    setState(ViewState.BUSY);
    this._movies = await this._movieUseCase.getMovies();
    setState(ViewState.IDLE);
  }

  void changeGridStatus() {
    this._isGrid = !_isGrid;
    this._animateList = true;
    setState(ViewState.IDLE);
  }
}
