class Product {
  String? name;
  String? loc;
  String? price;
  String? type;
  String? uid;
  String? email;

  Product({this.name, this.loc, this.price, this.type, this.uid, this.email});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['loc'] = this.loc;
    data['price'] = this.price;
    data['type'] = this.type;
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }

  static Product fromJson(Map<String, dynamic> json) => Product(
      name : json['name'],
      loc : json['loc'],
      price : json['price'],
  type : json['type'],
  uid : json['uid'],
    email : json['email']
  );


}