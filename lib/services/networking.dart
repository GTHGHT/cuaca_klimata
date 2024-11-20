import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<dynamic> getAPIResponse(String link) async {
    Uri url = Uri.parse(link);
    http.Response response = await http.get(url);

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return Future.error("Fail to get the data");
    }
  }
}
