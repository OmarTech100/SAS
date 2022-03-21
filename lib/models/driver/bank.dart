import 'dart:convert';

class Bank {
  String accountHolderName;
  String bankName;
  String ibanNumber;
  Bank({
    required this.accountHolderName,
    required this.bankName,
    required this.ibanNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      "accountHolderName": accountHolderName,
      "bankName": bankName,
      "ibanNumber": ibanNumber,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      accountHolderName: map["accountHolderName"],
      bankName: map["bankName"],
      ibanNumber: map["ibanNumber"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));
}
