import 'dart:convert';
import 'package:recycle/config.dart';
import 'package:recycle/model/tip.dart';
import 'package:http/http.dart' as http;

class TipsApi {

  static Future<List<Tip>> getTips(String query) async {
    Config config = Config();
    String _urlApi =config.getApiUrl();
    final url = Uri.parse(_urlApi + 'tips/' + query);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // check if is null
      if (response.body == 'null') {
        return [];
      }
      final List tips = json.decode(response.body);

      return tips.map((tip) => Tip.fromJson(tip)).toList();
    } else {
      throw Exception();
    }
  }
}
