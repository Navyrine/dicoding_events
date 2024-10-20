class Event {
  const Event({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    required this.imageLogo,
    required this.mediaCover,
    required this.category,
    required this.ownerName,
    required this.cityName,
    required this.quota,
    required this.registrants,
    required this.beginTime,
    required this.endTime,
    required this.link,
  });

  final int id;
  final String name;
  final String summary;
  final String description;
  final String imageLogo;
  final String mediaCover;
  final String category;
  final String ownerName;
  final String cityName;
  final int quota;
  final int registrants;
  final DateTime beginTime;
  final DateTime endTime;
  final String link;
}