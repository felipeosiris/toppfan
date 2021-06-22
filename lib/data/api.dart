import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:toppfan/models/DataRows.dart';

Future<String> _loadRowsFromApi() async {
  var dio = Dio();
  final response = await dio.get('https://filloy.com.mx/api/rows');
  //print(json.encode(response.data));
  return json.encode(response.data);
}

Future<DataRows> loadRows() async {
  String jsonString = await _loadRowsFromApi();
  final jsonResponse = json.decode(jsonString);
  DataRows dataRows = DataRows.fromJson(jsonResponse);
  //print(dataRows.rows.last.name);
  return dataRows;
}
