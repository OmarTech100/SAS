import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));
String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.orderId,
    this.userId,
    this.orderTime,
    this.type,
    this.brandName,
    this.brandPicture,
    this.amount,
    this.discount,
    this.orderTotal,
    this.invoiceStatus,
    this.deliveryStatus,
    this.paymentMethod,
    this.orderItems,
    this.customer,
    this.pickUpLocation,
    this.dropOffLocation,
  });

  String? orderId;
  String? userId;
  DateTime? orderTime;
  String? type;
  String? brandName;
  String? brandPicture;
  String? amount;
  String? discount;
  String? orderTotal;
  String? invoiceStatus;
  String? deliveryStatus;
  String? paymentMethod;
  List<OrderItem>? orderItems;
  Customer? customer;
  PickUpLocation? pickUpLocation;
  DropOffLocation? dropOffLocation;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        userId: json["userId"],
        orderTime: DateTime.parse(json["orderTime"]),
        type: json["type"],
        brandName: json["brandName"],
        brandPicture: json["brandPicture"],
        amount: json["amount"],
        discount: json["discount"],
        orderTotal: json["orderTotal"],
        invoiceStatus: json["invoiceStatus"],
        deliveryStatus: json['deliveryStatus'],
        paymentMethod: json["paymentMethod"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        customer: Customer.fromJson(json["customer"]),
        pickUpLocation: PickUpLocation.fromJson(json["pickUpLocation"]),
        dropOffLocation: DropOffLocation.fromJson(json["dropOffLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "userId": userId,
        "orderTime": orderTime!.toIso8601String(),
        "type": type,
        "brandName": brandName,
        "brandPicture": brandPicture,
        "amount": amount,
        "discount": discount,
        "orderTotal": orderTotal,
        "invoiceStatus": invoiceStatus,
        "deliveryStatus": deliveryStatus,
        "paymentMethod": paymentMethod,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "customer": customer!.toJson(),
        "pickUpLocation": pickUpLocation!.toJson(),
        "dropOffLocation": dropOffLocation!.toJson(),
      };
}

class Customer {
  Customer({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
  });

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
      };
}

class PickUpLocation {
  PickUpLocation({
    this.latitude,
    this.longitude,
  });

  String? latitude;
  String? longitude;

  factory PickUpLocation.fromJson(Map<String, dynamic> json) => PickUpLocation(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class DropOffLocation {
  DropOffLocation({
    this.latitude,
    this.longitude,
  });

  String? latitude;
  String? longitude;

  factory DropOffLocation.fromJson(Map<String, dynamic> json) =>
      DropOffLocation(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderItem {
  OrderItem({
    this.description,
    this.quantity,
  });

  String? description;
  String? quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        description: json["description"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "quantity": quantity,
      };
}
