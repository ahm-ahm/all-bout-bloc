import 'package:dio/dio.dart';

import '../../Utils/app_urls.dart';
import '../../Utils/general-helpers/pretty_logger.dart';

abstract class BaseService {
  Dio get dio => Dio(
        BaseOptions(
          // headers: _getAuthorizationHeader,
          headers: {'Content-Type': 'application/json'},
          baseUrl: AppUrls.baseUrl,
          connectTimeout: const Duration(seconds: 10),
        ),
      );

  //==================== Header For Dio ===================//
  Map<String, String>? get _getAuthorizationHeader {
    ///=========TODO: get token
    // var accessToken = PreferencesService.getAccessToken();
    /// for test
    String? accessToken;
    if (accessToken == null) {
      return null;
    } else {
      return {
        // "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      };
    }
  }

  BaseService() {
    var requestsLogger = PrettyDioLogger();

    dio.interceptors.add(requestsLogger);

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) async {
    //       log("++++++++++++++++ before request ++++++++++++++");
    //       // String? accessToken = PreferencesService.getAccessToken();
    //       // // JwtDecoder.isExpired(token)
    //       // await stateController.checkInternetStatus().then((value) async {
    //       //   log(stateController.internetConnection.value.toString());
    //       //   if (stateController.internetConnection.value == true) {
    //       //     log("device has internet");
    //       //
    //       //     if (accessToken == null ||
    //       //         accessToken == "null" ||
    //       //         accessToken!.isEmpty) {
    //       //       log("No access token $accessToken");
    //       //       return handler.next(options);
    //       //     } else {
    //       //       options.headers['Authorization'] = 'Bearer $accessToken';
    //       //       log(accessToken.toString());
    //       //       if (checkExpiry(accessToken!)) {
    //       //         log("token expired and refreshing  ${checkExpiry(accessToken!)} ");
    //       //         await Token()
    //       //             .refresh(accessToken!)
    //       //             .then((refreshResponse) async {
    //       //           if (refreshResponse["status"] == "false") {
    //       //             return handler.next(options);
    //       //           } else {
    //       //             accessToken = refreshResponse["token"];
    //       //             options.headers['Authorization'] =
    //       //             'Bearer ${refreshResponse["token"]}';
    //       //             PreferencesService.saveAccessToken(
    //       //                 refreshResponse["token"]);
    //       //             return handler.resolve(await retry(options));
    //       //           }
    //       //         });
    //       //       } else {
    //       //         log("token is not expired $accessToken");
    //       //         return handler.next(options);
    //       //       }
    //       //     }
    //       //   } else {
    //       //     ResponseDialogue(
    //       //         type: "net",
    //       //         h1: "No Internet connection",
    //       //         h2: "Make sure that Wi-Fi or mobile data is turned on, then try again.");
    //       //     return handler.next(options);
    //       //   }
    //       // });
    //     },
    //   ),
    // );
  }

  // bool checkExpiry(String token) {
  //   log("the expiry time of access token ${JwtDecoder.getExpirationDate(token)}");
  //   log("the remaining expiry time of access token ${JwtDecoder.getRemainingTime(token)}");
  //   return JwtDecoder.isExpired(token);
  // }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}

class Token {
  Dio dio = Dio();

  Future<dynamic> refresh(String token) async {
    var result;
    try {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      var response = await dio.post("${AppUrls.baseUrl}refreshToken",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      result = response.data;
    } on DioError {
      result = {"status": "false"};
    }

    return result;
  }
}
