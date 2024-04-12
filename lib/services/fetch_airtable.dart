import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<dynamic>> getAllQuizzes() async {
  List<dynamic> allRecords = [];

  String apiUrl = "https://api.airtable.com/v0/${dotenv.env['API_URI']}";

  bool hasMoreRecords = true;
  String offset = "0";

  while (hasMoreRecords) {
    final response = await Dio().get(
      apiUrl,
      queryParameters: {
        'offset': offset,
      },
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': dotenv.env['TOKEN'],
          'Accept': 'application/json',
        },
      ),
    );

    List<dynamic> records = response.data['records'];
    allRecords.addAll(records);

    if (response.data.containsKey('offset')) {
      offset = response.data['offset'];
    } else {
      hasMoreRecords = false;
    }
  }

  return allRecords;
}
