class Product {
  int id;
  String name, bannerPath, description;
  double star;
  double currentPrice,oldPrice;
  bool isSale;
  int quantity;

  String size;
  String color;


  Product({this.id, this.name, this.bannerPath, this.description, this.star,
    this.currentPrice, this.oldPrice, this.isSale});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["Id"],
      name: json["Name"],
      bannerPath: json["BannerPath"],
      currentPrice: json["CurrentPrice"],
      description: json["Description"],
      isSale: json["IsSale"],
      oldPrice: json["OldPrice"],
      star: json["Star"],
    );
  }

}