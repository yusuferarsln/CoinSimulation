import 'dart:io';

import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  late Dio dio;

  NetworkManager._init() {
    print('selam');
    final baseOptions = BaseOptions(
      followRedirects: false,
      contentType: Headers.formUrlEncodedContentType,
      validateStatus: (status) {
        return status! < 500;
      },
      baseUrl: 'https://api.coincap.io/v2/',
    );

    dio = Dio(baseOptions);
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onResponse: (e, handler) {
    //       return e.data;
    //     },
    //     onError: (e, handler) {
    //       print(e);
    //     },
    //     // onError: (e) {
    //     //   return BaseError(e.message);
    //     // },
    //   ),
    // );
  }
}
