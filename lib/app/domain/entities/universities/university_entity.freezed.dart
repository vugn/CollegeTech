// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'university_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UniversityEntity _$UniversityEntityFromJson(Map<String, dynamic> json) {
  return _UniversityEntity.fromJson(json);
}

/// @nodoc
mixin _$UniversityEntity {
  String get value => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UniversityEntityCopyWith<UniversityEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniversityEntityCopyWith<$Res> {
  factory $UniversityEntityCopyWith(
          UniversityEntity value, $Res Function(UniversityEntity) then) =
      _$UniversityEntityCopyWithImpl<$Res, UniversityEntity>;
  @useResult
  $Res call({String value, String name});
}

/// @nodoc
class _$UniversityEntityCopyWithImpl<$Res, $Val extends UniversityEntity>
    implements $UniversityEntityCopyWith<$Res> {
  _$UniversityEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UniversityEntityCopyWith<$Res>
    implements $UniversityEntityCopyWith<$Res> {
  factory _$$_UniversityEntityCopyWith(
          _$_UniversityEntity value, $Res Function(_$_UniversityEntity) then) =
      __$$_UniversityEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value, String name});
}

/// @nodoc
class __$$_UniversityEntityCopyWithImpl<$Res>
    extends _$UniversityEntityCopyWithImpl<$Res, _$_UniversityEntity>
    implements _$$_UniversityEntityCopyWith<$Res> {
  __$$_UniversityEntityCopyWithImpl(
      _$_UniversityEntity _value, $Res Function(_$_UniversityEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? name = null,
  }) {
    return _then(_$_UniversityEntity(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UniversityEntity implements _UniversityEntity {
  const _$_UniversityEntity({required this.value, required this.name});

  factory _$_UniversityEntity.fromJson(Map<String, dynamic> json) =>
      _$$_UniversityEntityFromJson(json);

  @override
  final String value;
  @override
  final String name;

  @override
  String toString() {
    return 'UniversityEntity(value: $value, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UniversityEntity &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UniversityEntityCopyWith<_$_UniversityEntity> get copyWith =>
      __$$_UniversityEntityCopyWithImpl<_$_UniversityEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UniversityEntityToJson(
      this,
    );
  }
}

abstract class _UniversityEntity implements UniversityEntity {
  const factory _UniversityEntity(
      {required final String value,
      required final String name}) = _$_UniversityEntity;

  factory _UniversityEntity.fromJson(Map<String, dynamic> json) =
      _$_UniversityEntity.fromJson;

  @override
  String get value;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_UniversityEntityCopyWith<_$_UniversityEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
