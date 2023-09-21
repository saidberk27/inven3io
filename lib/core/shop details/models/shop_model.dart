class Shop {
  late String shopName;
  late String shopImage;
  late Map<String, String> contactInfo;
  late String shopID;

  Shop(
      {required this.shopName,
      required this.shopImage,
      required this.contactInfo,
      required this.shopID});

  Map<String, dynamic> toJson() {
    return {
      'shopName': shopName,
      'shopImage': shopImage,
      'contactInfo': contactInfo,
      'shopID': shopID,
    };
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopName: json['shopName'],
      shopImage: json['shopImage'],
      contactInfo: Map<String, String>.from(json['contactInfo']),
      shopID: json['shopID'],
    );
  }
}
