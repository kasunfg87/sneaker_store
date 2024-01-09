part of 'objects.dart';

@JsonSerializable()
class FavouriteModel {
  final String category;
  // ignore: non_constant_identifier_names
  final int productId;
  final String uid;

  FavouriteModel({
    required this.category,
    required this.productId,
    required this.uid,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteModelToJson(this);
}
