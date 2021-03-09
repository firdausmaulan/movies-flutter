import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/data_manager/remote/api_helper.dart' as ApiHelper;

Future<Map> searchMovies(String query) async {
  if (query.isEmpty) return null;
  try {
    var response = await http.get(ApiHelper.searchMovies(query));
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
