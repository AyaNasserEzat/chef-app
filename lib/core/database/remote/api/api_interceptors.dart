import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['token'] = sl<CacheHelper>().getData(key: 'token') != null
        ? 'FOODAPI ${sl<CacheHelper>().getData(key: 'token')}'
        : null;


    super.onRequest(options, handler);
  }
}
