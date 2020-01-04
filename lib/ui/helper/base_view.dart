import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:state_management/locator.dart';
import 'package:state_management/view_model/base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget widget) _builder;
  final Function(T) _onModelReady;
  final T _model = locator<T>();

  BaseView({
    Function(T) onModelReady,
    @required Function(BuildContext context, T model, Widget widget) builder,
  })  : this._builder = builder,
        this._onModelReady = onModelReady;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        if (this._onModelReady != null) {
          this._onModelReady(this._model);
        }
        return this._model;
      },
      child: Consumer<T>(builder: this._builder),
    );
  }
}
