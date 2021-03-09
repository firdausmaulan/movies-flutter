import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/data_manager/remote/api_helper.dart' as ApiHelper;

Future<Map> requestMovies(var page) async {
  try {
    var response = await http.get(ApiHelper.getTopRated(page));
    print("response " + response.statusCode.toString());
    print("response " + response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  } on SocketException {
    return null;
  }
}
