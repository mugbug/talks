// ignore_for_file: avoid_classes_with_only_static_members

import 'package:profile/src/features/profile/data/dtos/profile_dto.dart';

class ProfileDTOFixture {
  static ProfileDTO base() {
    return ProfileDTO.fromJson(_baseJson);
  }

  static final Map<String, dynamic> _baseJson = {
    'id': 123,
    'name': 'fake name',
  };
}
