// ignore_for_file: non_constant_identifier_names

part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class EnrolledModel {
  final int course_id;
  final String status;
  final UserModel? user;
  final String last_update;

  EnrolledModel(
    this.course_id,
    this.status,
    this.user,
    this.last_update,
  );

  factory EnrolledModel.fromJson(Map<String, dynamic> json) =>
      _$EnrolledModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnrolledModelToJson(this);
}
