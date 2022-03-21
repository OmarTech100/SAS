import 'dart:convert';
import 'package:kayan/models/driver/driverLocation.dart';
import 'bank.dart';
import 'car.dart';
import 'driverLocation.dart';

class Driver {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? additionalMobileNumber;
  String? dateOfBirth;
  String? nationality;
  String? stcPayPhoneNumber;
  String? gender;
  String? drivingLicencePicture;
  String? idCardImage;
  String? carRegImage;
  String? idNumber;
  String? personalPhoto;
  String? city;
  String? status;
  String? registerDate;
  String? totalDistance;
  String? totalEarned;
  String? totalJobs;
  String? hasCompletedRegForm;
  Car? car;
  Bank? bank;
  DriverLocation? driverLocation;
  Driver({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.additionalMobileNumber,
    this.dateOfBirth,
    this.nationality,
    this.stcPayPhoneNumber,
    this.gender,
    this.drivingLicencePicture,
    this.idCardImage,
    this.carRegImage,
    this.idNumber,
    this.personalPhoto,
    this.city,
    this.status,
    this.registerDate,
    this.totalDistance,
    this.totalEarned,
    this.totalJobs,
    this.hasCompletedRegForm,
    this.car,
    this.bank,
    this.driverLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "mobileNumber": mobileNumber,
      "additionalMobileNumber": additionalMobileNumber,
      "dateOfBirth": dateOfBirth,
      "nationality": nationality,
      "stcPayPhoneNumber": stcPayPhoneNumber,
      "gender": gender,
      "drivingLicencePicture": drivingLicencePicture,
      "idNumber": idNumber,
      "personalPhoto": personalPhoto,
      "city": city,
      "status": status,
      "registerDate": registerDate,
      "totalDistance": totalDistance,
      "totalEarned": totalEarned,
      "totalJobs": totalJobs,
      "hasCompletedRegForm": hasCompletedRegForm,
      "idCardImage": idCardImage,
      "carRegImage": carRegImage,
      "car": car?.toMap(),
      "bank": bank?.toMap(),
      "driverLocation": driverLocation?.toMap()
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
        firstName: map["firstName"],
        lastName: map["lastName"],
        mobileNumber: map["mobileNumber"],
        additionalMobileNumber: map["additionalMobileNumber"],
        dateOfBirth: map["dateOfBirth"],
        nationality: map["nationality"],
        stcPayPhoneNumber: map["stcPayPhoneNumber"],
        gender: map["gender"],
        drivingLicencePicture: map["drivingLicencePicture"],
        idCardImage: map["idCardImage"],
        carRegImage: map["carRegImage"],
        idNumber: map["idNumber"],
        personalPhoto: map["personalPhoto"],
        city: map["city"],
        status: map["status"],
        registerDate: map["registerDate"],
        totalDistance: map["totalDistance"],
        totalEarned: map["totalEarned"],
        totalJobs: map["totalJobs"],
        hasCompletedRegForm: map["hasCompletedRegForm"],
        car: Car.fromMap(map["car"]),
        bank: Bank.fromMap(map["bank"]),
        driverLocation: DriverLocation.fromMap(map["driverLocation"]));
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) => Driver.fromMap(json.decode(source));
}
