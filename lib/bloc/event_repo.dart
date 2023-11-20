import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/model/model.dart';

class EventRepository {
  final String apiUrl;

  EventRepository(this.apiUrl);

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['content']['data'] != null) {
        final List<dynamic> eventsData = data['content']['data'];
        return eventsData.map((json) => Event.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  Future<List<Event>> searchEvents(String query) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?search=$query'));
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['content']['data'] != null) {
        final List<dynamic> eventsData = data['content']['data'];
        return eventsData.map((json) => Event.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }
}
