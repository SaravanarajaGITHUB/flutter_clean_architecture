import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:state_management/data/remote/web_service.dart';

class MockWebServiceImpl implements WebService {
  final AssetBundle _assetBundle;

  MockWebServiceImpl(this._assetBundle);

  @override
  Future<List<dynamic>> getMoviesResponse() async {
    final data = await this._assetBundle.loadString("assets/movies.json");
    return json.decode(data.toString());
  }
}
