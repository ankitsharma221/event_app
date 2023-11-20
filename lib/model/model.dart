class Event {
  final String bannerImage;
  final String title;
  final String dateTime;
  final String organiserName;
  final String organiserIcon; // Add this line
  final String venueName;
  final String venueCity;
  final String venueCountry;
  final String description;

  Event({
    required this.bannerImage,
    required this.title,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon, // And this line
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      bannerImage: json['banner_image'] ?? '',
      title: json['title'] ?? '',
      dateTime: json['date_time'] ?? '',
      organiserName: json['organiser_name'] ?? '',
      organiserIcon: json['organiser_icon'] ?? '', // And this line
      venueName: json['venue_name'] ?? '',
      venueCity: json['venue_city'] ?? '',
      venueCountry: json['venue_country'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
