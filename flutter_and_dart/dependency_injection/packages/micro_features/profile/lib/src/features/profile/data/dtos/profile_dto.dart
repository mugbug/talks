import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:profile/src/features/profile/business_logic/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@immutable
@JsonSerializable()
class ProfileDTO extends Equatable implements ProfileEntity {
  final int id;

  @override
  final String name;

  const ProfileDTO({
    required this.id,
    required this.name,
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDTOToJson(this);

  @override
  List<Object?> get props => [id, name];
}
