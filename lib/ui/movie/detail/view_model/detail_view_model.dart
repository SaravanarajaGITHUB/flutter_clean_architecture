import 'package:state_management/domain/model/response.dart';
import 'package:state_management/domain/usecase/detail/movie_detail_use_case.dart';
import 'package:state_management/ui/helper/base_view_model.dart';
import 'package:state_management/ui/helper/view_state.dart';
import 'package:state_management/ui/model/movie_model.dart';

class DetailViewModel extends BaseViewModel {
  final MovieDetailUseCase _movieUseCase;
  Response<MovieModel> _movie;

  Response<MovieModel> get movie => _movie;

  DetailViewModel(this._movieUseCase);

  Future<void> getMovie(String title) async {
    setState(ViewState.BUSY);
    this._movie = await this._movieUseCase.getMovie(title);
    setState(ViewState.IDLE);
  }
}
