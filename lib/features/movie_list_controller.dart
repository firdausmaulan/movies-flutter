import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/utils/constants.dart' as Constants;

Future<Map> requestMovies(var page) async {
  var url = Constants.BASE_URL +
      "/movie/top_rated?" +
      "page=$page" +
      "&api_key=${Constants.API_KEY}";
  try {
    var response = await http.get(url);
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
