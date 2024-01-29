// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      category: json['category'] as String,
      productId: json['productId'] as int,
      description: json['description'] as String,
      img: json['img'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'productId': instance.productId,
      'description': instance.description,
      'img': instance.img,
      'title': instance.title,
      'price': instance.price,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['fullName'] as String,
      json['email'] as String,
      json['location'] as String,
      json['mobileNo'] as String,
      json['img'] as String,
      json['lastSeen'] as String,
      json['isOnline'] as bool,
      json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'email': instance.email,
      'location': instance.location,
      'mobileNo': instance.mobileNo,
      'img': instance.img,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'token': instance.token,
    };

FavouriteModel _$FavouriteModelFromJson(Map<String, dynamic> json) =>
    FavouriteModel(
      category: json['category'] as String,
      productId: json['productId'] as int,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$FavouriteModelToJson(FavouriteModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'productId': instance.productId,
      'uid': instance.uid,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['id'] as String,
      (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      (json['userArray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastMassage'] as String,
      json['lastMassageTime'] as String,
      json['createdBy'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'userArray': instance.userArray.map((e) => e.toJson()).toList(),
      'lastMassage': instance.lastMassage,
      'lastMassageTime': instance.lastMassageTime,
      'createdBy': instance.createdBy,
    };

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: json['id'] as int,
      amount: json['amount'] as int,
      subTotal: (json['subTotal'] as num).toDouble(),
      productModel:
          ProductModel.fromJson(json['productModel'] as Map<String, dynamic>),
      size: json['size'] as String,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'subTotal': instance.subTotal,
      'productModel': instance.productModel.toJson(),
      'size': instance.size,
    };

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      productId: json['productId'] as int,
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      size: (json['size'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'productId': instance.productId,
      'colors': instance.colors,
      'size': instance.size,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'] as int,
      cartTotal: (json['cartTotal'] as num).toDouble(),
      delivery: (json['delivery'] as num).toDouble(),
      grandTotal: (json['grandTotal'] as num).toDouble(),
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'cartTotal': instance.cartTotal,
      'delivery': instance.delivery,
      'grandTotal': instance.grandTotal,
      'cartItems': instance.cartItems.map((e) => e.toJson()).toList(),
      'createdBy': instance.createdBy,
    };
