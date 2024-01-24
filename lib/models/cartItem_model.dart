// ignore_for_file: file_names

part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class CartItemModel {
  final int id;
  int amount;
  double subTotal;
  final ProductModel productModel;
  final String size;

  CartItemModel({
    required this.id,
    required this.amount,
    required this.subTotal,
    required this.productModel,
    required this.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
