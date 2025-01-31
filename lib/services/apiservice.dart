import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/models/loginform.dart';
import 'package:youapp/models/registerform.dart';

class ApiService extends GetxService {
  ReactiveController reactiveController = Get.put(ReactiveController());

  Uri _getUri(String endpoint) {
    return Uri.parse('http://192.168.100.189:3000/$endpoint');
  }


  Map<String, String> _headers(String branch) {
    final box = GetStorage();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${reactiveController.token.value}",
      "branch": branch,
    };
  }

  Future<http.Response> _sendRequest(
      Future<http.Response> Function() requestFunc, Uri uri,
      {dynamic body}) async {
    try {
      _logRequest(uri, body);
      final response = await requestFunc();
      _logResponse(uri, response);
      if (_isUnauthorized(response.statusCode)) {
        _handleUnauthorizedAccess();
      }
      return response;
    } catch (e) {
      log("Error during API call to $uri: $e");
      rethrow;
    }
  }

  void _logRequest(Uri uri, dynamic body) {
    log("Request URL: $uri");
    if (body != null) log("Request Body: ${jsonEncode(body)}");
  }

  void _logResponse(Uri uri, http.Response response) {
    log("Response for URL: $uri");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
  }

  bool _isUnauthorized(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }

  void _handleUnauthorizedAccess() {
    log("Unauthorized access detected.");
  }

  Future<http.Response> get(String endpoint) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(() => http.get(uri, headers: _headers("")), uri);
  }

  Future<String> fetchData(String endpoint) async {
    Uri uri = _getUri(endpoint);
    final response = await http.get(uri, headers: _headers(""));

    // Check the status code and return the body if successful
    if (response.statusCode == 200) {
      log(response.body);
      return response.body; // Return the response body as a String
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<http.Response> post(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(() => http.post(uri, headers: _headers(""), body: jsonEncode(body)), uri, body: body);
  }

  Future<http.Response> put(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
            () => http.put(uri, headers: _headers(""), body: jsonEncode(body)), uri,
        body: body);
  }

  Future<http.Response> patch(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
            () => http.patch(uri, headers: _headers(""), body: jsonEncode(body)), uri,
        body: body);
  }

  Future<http.Response> delete(String endpoint, {dynamic body}) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
            () => http.delete(uri, headers: _headers(""), body: jsonEncode(body)),
        uri,
        body: body);
  }

  Future<http.Response> updateProfileImage(String imagePath, endpoint, String branch) async {
    final uri = _getUri(endpoint);
    var request = http.MultipartRequest('PATCH', uri);

    request.headers.addAll(_headers(branch));
    request.files.add(await http.MultipartFile.fromPath('file', imagePath,contentType: MediaType("image", "jpeg")));

    _logRequest(uri, {"file": imagePath});

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    _logResponse(uri, response);

    return response;
  }

  Future<String> login() async {
    String passed = "";
    LoginformModel loginFormModel = LoginformModel(email: reactiveController.email.value, password: reactiveController.password.value);

    final response = await post('api/auth/login', loginFormModel);
    Map<String, dynamic> result = await jsonDecode(response.body);

    if(result.containsKey("token")){
      reactiveController.setToken(result["token"]);
      passed = "passed";
    }else{
      passed = response.body;
    }

    return passed;
  }

  Future<String> register() async {
    String passed = "";
    RegisterformModel loginFormModel = RegisterformModel(
        email: reactiveController.email.value,
        username: reactiveController.username.value,
        password: reactiveController.password.value,
        retype: reactiveController.retype.value
    );

    final response = await post('api/auth/register', loginFormModel);
    Map<String, dynamic> result = jsonDecode(response.body);

    if(result.containsKey("token")){
      reactiveController.setToken(result["token"]);
      passed = "passed";
    }else{
      passed = response.body;
    }

    return passed;
  }
}