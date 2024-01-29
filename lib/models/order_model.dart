part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final int orderId;
  double cartTotal;
  double delivery;
  double grandTotal;
  final List<CartItemModel> cartItems;
  final String createdBy;

  OrderModel(
      {required this.orderId,
      required this.cartTotal,
      required this.delivery,
      required this.grandTotal,
      required this.cartItems,
      required this.createdBy});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
