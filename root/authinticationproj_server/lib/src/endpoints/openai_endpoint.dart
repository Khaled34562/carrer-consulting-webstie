import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

class OpenAIEndpoint extends Endpoint {
  Future<String> getAIResponse(Session session, String city) async {
    // Replace with a real OpenAI API endpoint (if needed)
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric';

    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = json.decode(response.body);
        if (weatherData.containsKey('main') &&
            weatherData['main'].containsKey('temp')) {
          return '${weatherData['main']['temp']}°C';
        } else {
          return 'Weather data unavailable';
        }
      } else {
        return 'Error: API returned ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
