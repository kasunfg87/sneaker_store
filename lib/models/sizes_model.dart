part of 'objects.dart';

@JsonSerializable()
class SizeModel {
  final int productId;
  final List<String> colors;
  final List<String> size;

  SizeModel({
    required this.productId,
    required this.colors,
    required this.size,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeModelToJson(this);
}
