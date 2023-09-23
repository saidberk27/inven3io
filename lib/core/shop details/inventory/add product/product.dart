//Product Model
class Product {
  late String productName;
  late String productDesc;
  late String productBarcode;
  late double buyPrice;
  late double sellPrice;

  Product(
      {required this.productName,
      required this.productDesc,
      required this.productBarcode,
      required this.buyPrice,
      required this.sellPrice});

  Map<String, dynamic> toJson() {
    return {
      "productName": productName,
      "productDesc": productDesc,
      "productBarcode": productBarcode,
      "buyPrice": buyPrice,
      "sellPrice": sellPrice
    };
  }

  factory Product.fromJson({required Map<String, dynamic> json}) {
    return Product(
        productName: json["productName"],
        productDesc: json["productDesc"],
        productBarcode: json["productBarcode"],
        buyPrice: json["buyPrice"],
        sellPrice: json["sellPrice"]);
  }
}
