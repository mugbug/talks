import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:home/src/features/home/business_logic/entities/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_dto.g.dart';

@immutable
@JsonSerializable()
class HomeDTO extends Equatable implements HomeEntity {
  final int id;

  @override
  final String name;

  const HomeDTO({
    required this.id,
    required this.name,
  });

  factory HomeDTO.fromJson(Map<String, dynamic> json) =>
      _$HomeDTOFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDTOToJson(this);

  @override
  List<Object?> get props => [id, name];
}
