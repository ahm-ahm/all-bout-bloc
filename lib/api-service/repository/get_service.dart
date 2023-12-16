import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../Screens/Home-screen/models/todo.dart';
import '../../Utils/app_urls.dart';
import '../../Utils/general-helpers/pretty_logger.dart';
import 'base.dart';

class WebServices extends BaseService {
  static WebServices instance = WebServices._();
  WebServices._() : super();

  Future<dynamic> getData() async {
    try {
// customization
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      final response = await dio.get(AppUrls.todos);
      if (response.statusCode == 200) {
        return compute(getResponseOfData, response.data);
      }
    } on DioException catch (e) {
      rethrow;
    }
  }
}

//======================call compute of getData
List<Todo> getResponseOfData(dynamic data) {
  final List<Todo> list =
      List.generate(data.length, (index) => Todo.fromJson(data[index]));
  return list;
}
