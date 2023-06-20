import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_entity.freezed.dart';
part 'brand_entity.g.dart';

@freezed
class BrandEntity with _$BrandEntity {
  const factory BrandEntity({
    required String image,
    required String name,
    required List<dynamic> brands,
  }) = _BrandEntity;

  factory BrandEntity.fromJson(Map<String, dynamic> json) =>
      _$BrandEntityFromJson(json);
}
