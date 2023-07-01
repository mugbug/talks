import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tabbar/src/features/tabbar/business_logic/entities/tabbar_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tabbar_dto.g.dart';

@immutable
@JsonSerializable()
class TabbarDTO extends Equatable implements TabbarEntity {
  final int id;

  @override
  final String name;

  const TabbarDTO({
    required this.id,
    required this.name,
  });

  factory TabbarDTO.fromJson(Map<String, dynamic> json) =>
      _$TabbarDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TabbarDTOToJson(this);

  @override
  List<Object?> get props => [id, name];
}
