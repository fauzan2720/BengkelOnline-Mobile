class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? pinNumber;
  String? profilePhotoUrl;
  String? token;
  String? roles;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.pinNumber,
    this.profilePhotoUrl,
    this.token,
    this.roles,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    pinNumber = json['pin_number'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone_number': phoneNumber,
      'pin_number': pinNumber,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
      'roles': roles,
    };
  }
}
