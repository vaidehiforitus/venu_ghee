import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddProductRequestModel {
  String? name;
  double? price;
  String? unitType;
  double? weightVolume;
  String? image;

  AddProductRequestModel({
    this.name,
    this.price,
    this.unitType,
    this.weightVolume,
    this.image,
  });

  Future<FormData> toFormData({Uint8List? imageBytes}) async {
    final Map<String, dynamic> formMap = {};

    if (name != null) formMap['name'] = name;
    if (price != null) formMap['price'] = price.toString();
    if (unitType != null) formMap['unit_type'] = unitType;
    if (weightVolume != null) formMap['weight_volume'] = weightVolume.toString();

    if (kIsWeb) {
      if (imageBytes != null) {
        formMap['image'] = MultipartFile.fromBytes(
          imageBytes,
          filename: 'product_image.jpg',
        );
      }
    } else {
      if (image != null && image!.isNotEmpty) {
        formMap['image'] = await MultipartFile.fromFile(
          image!,
          filename: image!.split('/').last,
        );
      }
    }

    return FormData.fromMap(formMap);
  }
}