import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "AIzaSyD8HLFO57EY1PRH9HvpPZ8sDqIeJYaZWhw";
Future<num> analyzeSentiment({required String answer}) async {
  num score = 0.0;
  final url = Uri.parse(
      'https://language.googleapis.com/v1/documents:analyzeSentiment?key=$apiKey');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'document': {'type': 'PLAIN_TEXT', 'content': answer},
      'encodingType': 'UTF8',
    }),
  );

  if (response.statusCode == 200) {
    var sentimentData = jsonDecode(response.body);
    var sentiment = sentimentData['documentSentiment'];
    score = sentiment['score'];
    score = (score + 1) / 2;
  } else {
    print('Failed to analyze sentiment');
  }
  return score;
}
