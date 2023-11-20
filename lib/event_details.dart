import 'package:flutter/material.dart';
import 'package:task1/model/model.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key, required this.event});
  final Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.event.bannerImage,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width * (244 / 375),
                        width: MediaQuery.of(context).size.width,
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: Text('Event Details'),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.favorite, color: Colors.white),
                            onPressed: () {
                              // Handle favorite button press
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'International Band Music Concert',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 35 : 25,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                        widget.event.organiserIcon,
                      ),
                    ),
                    title: Text(widget.event.organiserName),
                    subtitle: Text('Organiser'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.calendar_today),
                    ),
                    title: Text(
                      DateFormat('d MMMM, yyyy')
                          .format(DateTime.parse(widget.event.dateTime)),
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, h:mm a - ')
                              .format(DateTime.parse(widget.event.dateTime)) +
                          DateFormat('h:mm a').format(
                              DateTime.parse(widget.event.dateTime)
                                  .add(Duration(hours: 5))),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.location_on),
                    ),
                    title: Text(widget.event.venueName),
                    subtitle: Text(
                        '${widget.event.venueCity}, ${widget.event.venueCountry}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.event.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 58,
          width: 271,
          decoration: BoxDecoration(
            color: Color(0xFF5669ff),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_right, color: Colors.white),
                TextButton(
                  onPressed: () {
                    // Handle book now button press
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
