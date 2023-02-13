
class ShopRegisterModel{
  late bool status;
  late String message;
  late UserRegisterData data;
  ShopRegisterModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = (json['data'] !=null ? UserRegisterData.fromJson(json['data']) : null)!;
  }
}

class UserRegisterData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserRegisterData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}