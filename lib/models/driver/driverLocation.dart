import 'dart:convert';

class DriverLocation {
  String latitude;
  String longitude;
  DriverLocation({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {"latitude": latitude, "longitude": longitude};
  }

  factory DriverLocation.fromMap(Map<String, dynamic> map) {
    return DriverLocation(
      latitude: map["latitude"],
      longitude: map["longitude"],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverLocation.fromJson(String source) =>
      DriverLocation.fromMap(json.decode(source));
}
