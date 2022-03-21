import 'dart:convert';

class Car {
  String type;
  String licensePlateNumbers;
  String licensePlateLitters;
  String color;
  String carFrontSidePic;
  String carBackSidePic;
  String carLeftSidePic;
  String carRightSidePic;
  Car({
    required this.type,
    required this.licensePlateNumbers,
    required this.licensePlateLitters,
    required this.color,
    required this.carFrontSidePic,
    required this.carBackSidePic,
    required this.carLeftSidePic,
    required this.carRightSidePic,
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "licensePlateNumbers": licensePlateNumbers,
      "licensePlateLitters": licensePlateLitters,
      "color": color,
      "carFrontSidePic": carFrontSidePic,
      "carBackSidePic": carBackSidePic,
      "carRightSidePic": carRightSidePic,
      "carLeftSidePic": carLeftSidePic
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      type: map["type"],
      licensePlateNumbers: map["licensePlateNumbers"],
      licensePlateLitters: map["licensePlateLitters"],
      color: map["color"],
      carFrontSidePic: map["carFrontSidePic"],
      carBackSidePic: map["carBackSidePic"],
      carLeftSidePic: map["carLeftSidePic"],
      carRightSidePic: map["carRightSidePic"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));
}
