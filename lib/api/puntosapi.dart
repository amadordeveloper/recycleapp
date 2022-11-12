import 'dart:convert';
import 'package:recycle/config.dart';
import 'package:recycle/model/puntolimpio.dart';
import 'package:http/http.dart' as http;

class PuntosLimpiosApi {

  static Future<List<PuntoLimpio>> getPuntosLimpios(String query) async {
    Config config = Config();
    String _urlApi =config.getApiUrl();
    final url = Uri.parse(_urlApi + 'puntosLimpios/' + query);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // check if is null
      if (response.body == 'null') {
        return [];
      }
      final List puntosLimpios = json.decode(response.body);

      return puntosLimpios.map((puntolimpio) => PuntoLimpio.fromJson(puntolimpio)).toList();
    } else {
      throw Exception();
    }
  }
}
