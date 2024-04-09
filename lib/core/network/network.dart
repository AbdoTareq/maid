import 'package:dio/dio.dart';
import 'package:tasks/core/constants.dart';
import 'package:tasks/core/error/exceptions.dart';
import 'package:tasks/core/feature/data/datasources/local_data_source.dart';

const _baseUrl = 'https://reqres.in/';

class Network {
  final Dio dio;
  final LocalDataSource box;
  Network({
    required this.dio,
    required this.box,
  });

  late Map<String, String?> headers;

  Future<Response> req(Future<Response> Function() requestType) async {
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (box.containsKey(kToken)) {
      headers = {
        ...headers,
        'Authorization': '${box.read(kToken)!['token']}',
      };
    }
    try {
      final response = await requestType();
      if (response.statusCode! > 210 || response.statusCode! < 200) {
        throw ServerException(message: response.data.toString());
      }
      // success
      return response;
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> post(
    String endPoint,
    dynamic body,
  ) async {
    return req(
      () {
        return dio.post(
          _baseUrl + endPoint,
          data: body,
          options: Options(headers: headers),
        );
      },
    );
  }

  Future<Response> patch(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.patch(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> delete(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.delete(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> get(String endPoint, dynamic body) {
    return req(() {
      return dio.get(_baseUrl + endPoint, options: Options(headers: headers));
    });
  }
}
