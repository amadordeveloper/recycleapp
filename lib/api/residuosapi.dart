import 'dart:convert';
import 'package:recycle/config.dart';
import 'package:recycle/model/residuo.dart';
import 'package:http/http.dart' as http;

class ResiduosApi {

  static Future<List<Residuo>> getResiduos(String query) async {
    Config config = Config();
    String _urlApi =config.getApiUrl();
    final url = Uri.parse(_urlApi + 'residuos/' + query);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // check if is null
      if (response.body == 'null') {
        return [];
      }
      final List residuos = json.decode(response.body);

      return residuos.map((residuo) => Residuo.fromJson(residuo)).toList();
    } else {
      throw Exception();
    }
  }
}
