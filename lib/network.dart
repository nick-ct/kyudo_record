import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> checkEventCalendarUrlValid(String url) async {
  try {
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body)['checking'] == 'forKyudoRecordUse';
    }
    return false;
  } on Exception catch (_) {
    return false;
  }
}

Future<Map> getEventCalendarUrlData(String url) async {
  var uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    return jsonDecode(response.body);
  }
  return {};
}
