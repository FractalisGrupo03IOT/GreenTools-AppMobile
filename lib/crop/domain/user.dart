class User {
  final int id;
  final Name name;
  final Email email;
  final String profileImage;
  final Address address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: Name.fromJson(json['name']),
      email: Email.fromJson(json['email']),
      profileImage: json['profileImage'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'email': email.toJson(),
      'profileImage': profileImage,
      'address': address.toJson(),
    };
  }
}

class Name {
  final String firstName;
  final String lastName;

  Name({required this.firstName, required this.lastName});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class Email {
  final String address;

  Email({required this.address});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
    };
  }
}

class Address {
  final String street;
  final String number;
  final String city;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.number,
    required this.city,
    required this.zipCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      number: json['number'],
      city: json['city'],
      zipCode: json['zipCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'number': number,
      'city': city,
      'zipCode': zipCode,
      'country': country,
    };
  }
}

