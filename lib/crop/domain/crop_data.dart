class CropData {
  final int id;
  final int plantId;
  final double humidity;
  final double temperature;
  final double uv;
  final String dataDate;

  CropData({
    required this.id,
    required this.plantId,
    required this.humidity,
    required this.temperature,
    required this.uv,
    required this.dataDate,
  });

  factory CropData.fromJson(Map<String, dynamic> json) {
    return CropData(
      id: json['id'],
      plantId: json['plantId'],
      humidity: json['humidity'].toDouble(),
      temperature: json['temperature'].toDouble(),
      uv: json['uv'].toDouble(),
      dataDate: json['dataDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plantId': plantId,
      'humidity': humidity,
      'temperature': temperature,
      'uv': uv,
      'dataDate': dataDate,
    };
  }
}
