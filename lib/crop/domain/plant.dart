class Plant {
  final int id;
  final int stationId;
  final String name;
  final String plantImage;

  Plant({
    required this.id,
    required this.stationId,
    required this.name,
    required this.plantImage,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      stationId: json['stationId'],
      name: json['name'],
      plantImage: json['plantImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stationId': stationId,
      'name': name,
      'plantImage': plantImage,
    };
  }
}

