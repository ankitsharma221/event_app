import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:math'; // Import the dart:math library
import 'package:task1/bloc/event_repo.dart';
import 'package:task1/bloc/events.dart';
import 'package:task1/bloc/states.dart';
import 'package:task1/event_details.dart';
import 'package:task1/model/model.dart';
import 'bloc/bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc(EventRepository(
          'https://sde-007.api.assignment.theinternetfolks.works/v1/event')),
      child: const SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchText = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  searchText = value;
                  BlocProvider.of<EventBloc>(context)
                      .add(SearchTextChanged(value));
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type event name',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF5669ff)),
                ),
              ),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    final events = state.events;
                    return _buildEventList(context, events);
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container(); // Handle other states if needed
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(BuildContext context, List<Event> events) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

            return buildEventList(events, crossAxisCount);
          },
        ),
      ),
    );
  }

  Widget buildEventList(List<Event> events, int crossAxisCount) {
    if (crossAxisCount == 2) {
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
            child: buildEventCard(event, crossAxisCount),
          );
        },
      );
    } else {
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
            child: buildEventCard(event, crossAxisCount),
          );
        },
      );
    }
  }

  Widget buildEventCard(Event event, int crossAxisCount) {
    DateTime dateTime = DateTime.parse(event.dateTime);
    String formattedDateTime =
        DateFormat('EEE, MMM d • h:mm a').format(dateTime);

    double fontSizeTitle = min(
      crossAxisCount == 2 ? 24.0 : 18.0,
      crossAxisCount == 2 ? 24.0 : 18.0,
    ); // Increase the title font size
    double fontSizeDateTime = min(
      crossAxisCount == 2 ? 13.0 : 12.0,
      crossAxisCount == 2 ? 13.0 : 12.0,
    ); // Adjust as needed

    return Container(
      height: crossAxisCount == 2 ? 180.0 : 106.0,
      width: crossAxisCount == 2 ? 160.0 : 327.0,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(event.bannerImage,
                    width: crossAxisCount == 2 ? 79 : 92,
                    height: crossAxisCount == 2 ? 92 : 79,
                    fit: BoxFit.fill),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: crossAxisCount == 2 ? 11.0 : 8.0),
                  Text(formattedDateTime,
                      style: TextStyle(
                        fontSize: fontSizeDateTime,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5669ff),
                      )),
                  SizedBox(height: crossAxisCount == 2 ? 15.0 : 4.0),
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF120D26),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: crossAxisCount == 2 ? 11.0 : 4.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
