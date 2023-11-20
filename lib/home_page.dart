import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task1/event_details.dart';
import 'package:task1/model/model.dart';
import 'package:task1/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Event> events;

  @override
  void initState() {
    super.initState();
    events = [];
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(
          'https://sde-007.api.assignment.theinternetfolks.works/v1/event'));
      print('API response: ${response.body}');
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['content']['data'] != null) {
        final List<dynamic> eventsData = data['content']['data'];
        setState(() {
          events = eventsData.map((json) => Event.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Failed to fetch events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Events',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          PopupMenuButton(
            color: Colors.black,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                child: Text('Sort by date'),
              ),
              const PopupMenuItem(
                child: Text('Sort by venue'),
              ),
            ],
          ),
        ],
      ),
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                return buildEventList(crossAxisCount);
              },
            ),
    );
  }

  Widget buildEventList(int crossAxisCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: crossAxisCount == 2 ? buildEventGrid() : buildEventListVertical(),
    );
  }

  Widget buildEventGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetails(event: event),
              ),
            );
          },
          child: buildEventCard(event),
        );
      },
    );
  }

  Widget buildEventListVertical() {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetails(event: event),
              ),
            );
          },
          child: buildEventCard(event),
        );
      },
    );
  }

  Widget buildEventCard(Event event) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(event.dateTime);
    } catch (e) {
      print('Error parsing date-time: $e');
      dateTime = DateTime.now(); // Use current date-time as fallback
    }
    String formattedDateTime =
        DateFormat('EEE, MMM d • h:mm a').format(dateTime);

    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 106.0,
      width: 327,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  event.bannerImage,
                  width: 79,
                  height: 92,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3.0),
                  Text(
                    formattedDateTime,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5669ff),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF120D26),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 11.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.grey, size: 15),
                          Text(
                            '${event.venueName.length > 24 ? event.venueName.substring(0, 24) + '...' : event.venueName}',
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '  • ${event.venueCity} ',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
