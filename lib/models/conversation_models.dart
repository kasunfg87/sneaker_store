part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  String id;
  List<String> users;
  List<UserModel> userArray;
  String lastMassage;
  String lastMassageTime;
  String createdBy;

  ConversationModel(
    this.id,
    this.users,
    this.userArray,
    this.lastMassage,
    this.lastMassageTime,
    this.createdBy,
  );

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
