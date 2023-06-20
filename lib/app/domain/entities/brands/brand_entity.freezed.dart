// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BrandEntity _$BrandEntityFromJson(Map<String, dynamic> json) {
  return _BrandEntity.fromJson(json);
}

/// @nodoc
mixin _$BrandEntity {
  String get image => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<dynamic> get brands => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BrandEntityCopyWith<BrandEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandEntityCopyWith<$Res> {
  factory $BrandEntityCopyWith(
          BrandEntity value, $Res Function(BrandEntity) then) =
      _$BrandEntityCopyWithImpl<$Res, BrandEntity>;
  @useResult
  $Res call({String image, String name, List<dynamic> brands});
}

/// @nodoc
class _$BrandEntityCopyWithImpl<$Res, $Val extends BrandEntity>
    implements $BrandEntityCopyWith<$Res> {
  _$BrandEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? name = null,
    Object? brands = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BrandEntityCopyWith<$Res>
    implements $BrandEntityCopyWith<$Res> {
  factory _$$_BrandEntityCopyWith(
          _$_BrandEntity value, $Res Function(_$_BrandEntity) then) =
      __$$_BrandEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, String name, List<dynamic> brands});
}

/// @nodoc
class __$$_BrandEntityCopyWithImpl<$Res>
    extends _$BrandEntityCopyWithImpl<$Res, _$_BrandEntity>
    implements _$$_BrandEntityCopyWith<$Res> {
  __$$_BrandEntityCopyWithImpl(
      _$_BrandEntity _value, $Res Function(_$_BrandEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? name = null,
    Object? brands = null,
  }) {
    return _then(_$_BrandEntity(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BrandEntity implements _BrandEntity {
  const _$_BrandEntity(
      {required this.image,
      required this.name,
      required final List<dynamic> brands})
      : _brands = brands;

  factory _$_BrandEntity.fromJson(Map<String, dynamic> json) =>
      _$$_BrandEntityFromJson(json);

  @override
  final String image;
  @override
  final String name;
  final List<dynamic> _brands;
  @override
  List<dynamic> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  @override
  String toString() {
    return 'BrandEntity(image: $image, name: $name, brands: $brands)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BrandEntity &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._brands, _brands));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, image, name, const DeepCollectionEquality().hash(_brands));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BrandEntityCopyWith<_$_BrandEntity> get copyWith =>
      __$$_BrandEntityCopyWithImpl<_$_BrandEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BrandEntityToJson(
      this,
    );
  }
}

abstract class _BrandEntity implements BrandEntity {
  const factory _BrandEntity(
      {required final String image,
      required final String name,
      required final List<dynamic> brands}) = _$_BrandEntity;

  factory _BrandEntity.fromJson(Map<String, dynamic> json) =
      _$_BrandEntity.fromJson;

  @override
  String get image;
  @override
  String get name;
  @override
  List<dynamic> get brands;
  @override
  @JsonKey(ignore: true)
  _$$_BrandEntityCopyWith<_$_BrandEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
