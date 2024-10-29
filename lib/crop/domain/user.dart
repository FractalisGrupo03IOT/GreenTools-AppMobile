class CropInfo {
  final String cropName;
  final String cropImageUrl;
  final Map<String, String> careIcons;

  CropInfo({
    required this.cropName,
    required this.cropImageUrl,
    required this.careIcons,
  });

  factory CropInfo.fromJson(Map<String, dynamic> json) {
    return CropInfo(
      cropName: json['cropName'],
      cropImageUrl: json['cropImageUrl'],
      careIcons: Map<String, String>.from(json['careIcons']),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String greeting;
  final String profileImageUrl;
  final List<CropInfo> crops;

  User({
    required this.firstName,
    required this.lastName,
    required this.greeting,
    required this.profileImageUrl,
    required this.crops,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<CropInfo> crops =
    (json['crops'] as List).map((i) => CropInfo.fromJson(i)).toList();
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      greeting: json['greeting'],
      profileImageUrl: json['profileImageUrl'],
      crops: crops,
    );
  }
}