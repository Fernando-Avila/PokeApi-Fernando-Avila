import 'package:http/http.dart' as http;
import 'dart:convert';

class Services {
  Future<dynamic> httpGet(String path) async {
    var url = Uri.parse(path);
    var value = await http.get(url).then((value) async {
      return value;
    });
    return value;
  }

  Future<dynamic> httpPost(String path, body) async {
    var url = Uri.parse(path);
    return await http.post(url, body: body).then((value) async {
      return value;
    });
  }

  Future<dynamic> httpPut(String path, body) async {
    var url = Uri.parse(path);
    return await http.put(url, body: body).then((value) async {
      return value;
    });
  }

  Future<dynamic> httpDelete(String path, int id) async {
    var url = Uri.parse(path);
    var header = {
      'content-type': 'application/json',
      'accept': 'application/json',
      "connection": "Keep-Alive",
    };
    return await http.delete(url).then((value) async {
      return value;
    });
  }

  Future<dynamic> httpPostRequest(request) async {
    //var request =
    //http.MultipartRequest("POST", Uri.parse( path));
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<dynamic> httpGetList(String path) async {
    var url = Uri.parse(path);
    http.get(url).then((value) async {
      return value;
    });
  }

  jsondecode(body) {
    return jsonDecode(body);
  }
}
