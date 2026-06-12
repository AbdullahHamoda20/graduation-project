import 'package:dio/dio.dart';
import 'package:pcos_app/core/network/perf_helper.dart';

class DioClint {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://pcos-health.runasp.net/api/',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  bool _isRefreshing = false;


  final List<Function(String)> _retryQueue = [];

  DioClint() {
    _dio.interceptors.add(
      InterceptorsWrapper(

        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },


        onError: (error, handler) async {

          if (error.response?.statusCode == 401) {


            if (_isRefreshing) {

              return _retryRequest(error.requestOptions, handler);
            }

            _isRefreshing = true;

            try {
              final refreshToken = await PrefHelper.getRefreshToken();

              final response = await _dio.post(
                "Account/refresh-token",
                data: refreshToken,
              );

              final newToken = response.data["token"];
              final newRefresh = response.data["refreshToken"];

              await PrefHelper.saveToken(newToken);
              await PrefHelper.saveRefreshToken(newRefresh);

              _isRefreshing = false;

              // 🔁 نفذ كل اللي مستني
              for (var request in _retryQueue) {
                request(newToken);
              }
              _retryQueue.clear();

              // 🔁 retry الحالي
              final requestOptions = error.requestOptions;
              requestOptions.headers["Authorization"] =
              "Bearer $newToken";

              final clonedResponse = await _dio.fetch(requestOptions);

              return handler.resolve(clonedResponse);

            } catch (e) {
              _isRefreshing = false;

              await PrefHelper.clearAll();

              return handler.next(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _retryRequest(
      RequestOptions requestOptions,
      ErrorInterceptorHandler handler,
      ) async {

    _retryQueue.add((token) async {
      requestOptions.headers["Authorization"] = "Bearer $token";

      final response = await _dio.fetch(requestOptions);

      handler.resolve(response);
    });
  }

  Dio get dio => _dio;
}