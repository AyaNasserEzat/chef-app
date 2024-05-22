
class ChefModel {
  Map<String,dynamic>? location;
  String id;
 final String name;
 final String phone;
 final String email;
 final String brandName;
  String profilePic;
  final int minCharge;
  String disc;
  String frontId;
  String backId;
  List<dynamic> menu;
  bool online;
  String healthCertificate;
  int stock;
  String status;
  DateTime createdAt;

  ChefModel({
   required this.location,
   required this.id,
   required this.name,
   required this.phone,
   required this.email,
   required this.brandName,
   required this.profilePic,
   required this.minCharge,
   required this.disc,
   required this.frontId,
   required this.backId,
   required this.menu,
   required this.online,
   required this.healthCertificate,
   required this.stock,
   required this.status,
   required this.createdAt,
  });

 factory ChefModel.fromJson(Map<String, dynamic> json) {
    return ChefModel(
      location: json['chef']['location'], 
      id: json['chef']['_id'],
      name: json['chef']['name'],
      phone: json['chef']['phone'],
      email: json['chef']['email'],
      brandName: json['chef']['brandName'],
      profilePic: json['chef']['profilePic'],
      minCharge: json['chef']['minCharge'],
      disc: json['chef']['disc'],
      frontId: json['chef']['frontId'],
      backId: json['chef']['backId'],
      menu: json['chef']['menu'],
      online: json['chef']['online'],
      healthCertificate: json['chef']['healthCertificate'],
      stock: json['chef']['stock'],
      status: json['chef']['status'],
      createdAt: DateTime.parse(json['chef']['createdAt']),
    );
  }

}

