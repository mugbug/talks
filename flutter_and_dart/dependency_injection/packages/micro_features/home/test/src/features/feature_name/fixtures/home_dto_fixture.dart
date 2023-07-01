// ignore_for_file: avoid_classes_with_only_static_members

import 'package:home/src/features/home/data/dtos/home_dto.dart';

class HomeDTOFixture {
  static HomeDTO base() {
    return HomeDTO.fromJson(_baseJson);
  }

  static final Map<String, dynamic> _baseJson = {
    'id': 123,
    'name': 'fake name',
  };
}
