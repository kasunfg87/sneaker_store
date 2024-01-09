part of 'objects.dart';

@JsonSerializable()
class ProductModel {
  final String category;
  final int productId;
  final String description;
  final String img;
  final String title;
  final double price;

  ProductModel(
      {required this.category,
      required this.productId,
      required this.description,
      required this.img,
      required this.title,
      required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
