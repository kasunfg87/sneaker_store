part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel {
  String conId;
  String senderName;
  String senderId;
  String receiverId;
  String message;
  String messageTime;

  MessageModel(
    this.conId,
    this.senderName,
    this.senderId,
    this.receiverId,
    this.message,
    this.messageTime,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
