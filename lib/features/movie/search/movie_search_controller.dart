import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/data_manager/remote/api_constants.dart' as ApiConstants;

Future<Map> searchMovies(String query) async {
  if (query.isEmpty) return null;
  final uri = new Uri.https(
      ApiConstants.BASE_URL,
      "3/search/movie",
      {"query": query, "api_key": ApiConstants.API_KEY});
  try {
    var response = await http.get(uri);
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
