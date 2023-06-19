import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_entity.freezed.dart';
part 'brand_entity.g.dart';

@freezed
class BrandEntity with _$BrandEntity {
  const factory BrandEntity({
    required String value,
    required String name,
  }) = _BrandEntity;

  factory BrandEntity.fromJson(Map<String, dynamic> json) =>
      _$BrandEntityFromJson(json);
}
