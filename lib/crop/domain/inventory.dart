class Inventory {
  final int id;
  final String stationName;
  final int userId;
  final String plant;
  final int temperature;
  final int uvSolar;
  final int humidity;

  Inventory({
    required this.id,
    required this.stationName,
    required this.userId,
    required this.plant,
    required this.temperature, 
    required this.uvSolar,
    required this.humidity,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {

    return Inventory(
      id: json['id'],
      stationName: json['stationName'],
      userId: json['user_id'],
      plant: json['plant'],
      temperature: json['temperature'],
      uvSolar: json['uvSolar'],
      humidity: json['humidity'],
    );
  }
}
