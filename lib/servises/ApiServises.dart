import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> post({
    required String url,
    required var body,
    required String token,
    Map<String, String>? headers,
    String? content,
  }) async {
    http.Response response = await http.post(Uri.parse(url),
        body: body,
        headers: headers ??
            {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/x-www-form-urlencoded',
            });
    var data = jsonDecode(response.body);
    return data;
  }
}
