class Station {
  final int id;
  final int userId;
  final String stationName;
  final String description;
  final String stationImage;
  final String startDate;
  final String endDate;

  Station({
    required this.id,
    required this.userId,
    required this.stationName,
    required this.description,
    required this.stationImage,
    required this.startDate,
    required this.endDate,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['Id'],
      userId: json['userId'],
      stationName: json['stationName'],
      description: json['description'],
      stationImage: json['stationImage'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'userId': userId,
      'stationName': stationName,
      'description': description,
      'stationImage': stationImage,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
