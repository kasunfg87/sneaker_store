part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final int orderId;
  double cartTotal;
  double discount;
  double grandTotal;
  final CartItemModel cartItemModel;

  OrderModel({
    required this.orderId,
    required this.cartTotal,
    required this.discount,
    required this.grandTotal,
    required this.cartItemModel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
