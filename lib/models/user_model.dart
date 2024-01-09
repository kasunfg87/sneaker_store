part of 'objects.dart';


@JsonSerializable()

class UserModel {

  final String uid;


  final String fullName;


  final String email;


  String location;


  String mobileNo;


  String img;


  String lastSeen;


  bool isOnline;


  @JsonKey(defaultValue: "")

  String token;


  UserModel(

    this.uid,

    this.fullName,

    this.email,

    this.location,

    this.mobileNo,

    this.img,

    this.lastSeen,

    this.isOnline,

    this.token,

  );


  factory UserModel.fromJson(Map<String, dynamic> json) =>

      _$UserModelFromJson(json);


  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}

