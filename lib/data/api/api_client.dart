import 'dart:convert';
import 'package:get/get.dart';
import 'package:new_app/utils/app_constants.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as Http;
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' as Foundation;
// ignore_for_file: library_prefixes, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

class ApiClient extends GetxService {
  final String appBaseUrl = AppConstants.BASE_URL;

  Map<String, String>? _mainHeaders;

  ApiClient() {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  // Future<Response> getLocation(String text) async {
  //   var client = Http.Client();
  //   try {
  //     debugPrint(
  //         'Final URL==>${Uri.parse(AppConstants.BASE_URL + AppConstants.SEARCH_LOCATION_URI + text)}');
  //     Http.Response _response = await client
  //         .get(
  //           Uri.parse(AppConstants.BASE_URL +
  //               AppConstants.SEARCH_LOCATION_URI +
  //               text),
  //         )
  //         .timeout(const Duration(seconds: 30));
  //     Response response = handleResponse(_response);
  //     debugPrint('API Response===> Return Success ');
  //     return response;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        headers['Content-Type'] = 'application/json';
      }
      _mainHeaders = {'Content-Type': 'application/json'};
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Http.Response _response = await Http.get(
        Uri.parse(uri),
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getWithParamsData(String uri, String baseUrl,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    }
    try {
      Http.Response _response = await Http.get(
        Uri.https(baseUrl, uri, queryParameters),
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers, bool isRefresh = false}) async {
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = '*/*';
    }

    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');

      Logger().log(Level.info, '==>Header: ${headers ?? _mainHeaders}');
      debugPrint('==>Header: ${headers ?? _mainHeaders}');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 60));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    }
    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');
      debugPrint('==>Header: $_mainHeaders');
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        body: body != null ? jsonEncode(body) : null,
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    }
    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');
      debugPrint('==>Header: $_mainHeaders');
      Http.Response _response = await Http.patch(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint('Exception ===>$e');
    }
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        debugPrint('==>from if');

        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.bodyString);
      } else if (_response.body.toString().startsWith('{success')) {
        debugPrint('==>from else if');
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      } else if (_response.body.toString().startsWith('{status')) {
        debugPrint('==>from status');
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(
          statusCode: 0,
          statusText:
              'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}
