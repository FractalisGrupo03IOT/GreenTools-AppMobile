class CropAvailable {
  final String cropName;
  final String cropImageUrl;
  final Map<String, String> careIcons;
  final String description;
  final String recommendation;

  CropAvailable({
    required this.cropName,
    required this.cropImageUrl,
    required this.careIcons,
    required this.description,
    required this.recommendation,
  });

  factory CropAvailable.fromJson(Map<String, dynamic> json) {
    return CropAvailable(
      cropName: json['cropName'],
      cropImageUrl: json['cropImageUrl'] ??
          '', // Provide a default value if plantImageUrl is null
      careIcons: Map<String, String>.from(json['careIcons']),
      description: json['description'],
      recommendation: json['recommendation'],
    );
  }
}