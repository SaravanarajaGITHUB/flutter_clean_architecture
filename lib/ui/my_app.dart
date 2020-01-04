import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management/ui/movie/detail/view/detail_page.dart';
import 'package:state_management/ui/movie/list/view/movie_list_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  bool _initApp = true;
  final ValueSetter<BuildContext> _init;

  MyApp({@required ValueSetter<BuildContext> init}) : this._init = init;

  @override
  Widget build(BuildContext context) {
    if (this._initApp) {
      this._init(context);
      this._initApp = false;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        splashColor: Colors.brown.withOpacity(0.3),
      ),
      initialRoute: MovieListPage.routeName,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case MovieListPage.routeName:
            return MaterialPageRoute(
                builder: (context) => MovieListPage(), settings: routeSettings);
          case DetailPage.route_name:
            return MaterialPageRoute(
                builder: (context) => DetailPage(routeSettings.arguments),
                settings: routeSettings);
          default:
            return MaterialPageRoute(
                builder: (context) => MovieListPage(), settings: routeSettings);
        }
      },
    );
  }
}
