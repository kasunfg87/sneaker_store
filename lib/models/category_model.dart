part of 'objects.dart';

@JsonSerializable()
class CategoryModel {
  final String? categoryId;
  final String? categoryName;

  // ignore: non_constant_identifier_names
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
