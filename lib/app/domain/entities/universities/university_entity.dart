import 'package:freezed_annotation/freezed_annotation.dart';

part 'university_entity.freezed.dart';
part 'university_entity.g.dart';

@freezed
class UniversityEntity with _$UniversityEntity {
  const factory UniversityEntity({
    required String value,
    required String name,
  }) = _UniversityEntity;

  factory UniversityEntity.fromJson(Map<String, dynamic> json) =>
      _$UniversityEntityFromJson(json);
}
