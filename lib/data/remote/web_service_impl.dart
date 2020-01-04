import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:state_management/data/service/app_exception.dart';
import 'package:state_management/data/service/web_service.dart';

class WebServiceImpl implements WebService {
  final String _baseUrl = "https://api.androidhive.info";

  Future<dynamic> get(String path) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + path);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case HttpStatus.badRequest:
        throw BadRequestException(response.body.toString());
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw UnauthorisedException(response.body.toString());
      case HttpStatus.internalServerError:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  @override
  Future<List<dynamic>> getMoviesResponse() async {
    return await this.get('/json/movies.json');
  }
}
