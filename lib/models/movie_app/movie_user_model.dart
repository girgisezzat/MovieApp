class MovieUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;

  MovieUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified,
  });

  MovieUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
    };
  }
}