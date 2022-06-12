import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String url = 'https://simrs-smilingdev.000webhostapp.com/api/v1/';
  final String url = 'http://127.0.0.1:8000/api/v1/';
  final String _url = 'http://127.0.0.1:8000/api/';
  // Future<Post> getPublicData(endPoint) async {
  //   final response = await http.get(Uri.parse('$_url$endPoint/1'));
  //   try {
  //     if (response.statusCode == 200) {
  //       print(Post.fromJson(json.decode(response.body)).body);
  //       return Post.fromJson(json.decode(response.body));
//     } else {
  //       throw Exception('Failed to load post');
  //     }
  //   } catch (e) {
  //     print(e);
  //     return 'failed';
  //   }
  // }

  getPublicData(endPoint) async {
    Response response = await http.get(Uri.parse('$url$endPoint'));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(data);
    try {
      return await http.post(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
    } catch (e) {
      print(e);
    }
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
