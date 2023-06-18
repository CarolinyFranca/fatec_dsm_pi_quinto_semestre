import 'dart:convert';
import 'dart:developer';

import 'package:frontend/model/alert_event_model.dart';
import 'package:http/http.dart';

String username = 'carol@carol.carol';
String password = 'carol';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

Future<List<AlertEvent>> getAlertEvent() async {
  Response response = await get(
      Uri.parse(
          'https://guiame-api.3far1ivu8btka.us-east-1.cs.amazonlightsail.com/evento'),
      headers: {'authorization': basicAuth});

  if (response.statusCode == 200) {
    print('Response: \n${response.body}');

    List<dynamic> jsonResult = jsonDecode(response.body);

    List<AlertEvent> alerts = jsonResult.map((e) =>  AlertEvent.fromJson(e)).toList();

    // var list = jsonResult.map((e) =>  AlertEvent.fromJson(e)).toList();

    return alerts;
  } else {
    log('Falha na requisição! Status Code: ${response.statusCode}; Body: ${response.body}');
    throw Exception('Code: ${response.statusCode}. Body: ${response.body}');
  }
}
