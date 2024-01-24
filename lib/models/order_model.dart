part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final int orderId;
  double cartTotal;
  double delivery;
  double grandTotal;
  final List<CartItemModel> cartItems;

  OrderModel({
    required this.orderId,
    required this.cartTotal,
    required this.delivery,
    required this.grandTotal,
    required this.cartItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
