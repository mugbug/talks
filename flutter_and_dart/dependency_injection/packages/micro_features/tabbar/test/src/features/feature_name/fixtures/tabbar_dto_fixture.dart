// ignore_for_file: avoid_classes_with_only_static_members

import 'package:tabbar/src/features/tabbar/data/dtos/tabbar_dto.dart';

class TabbarDTOFixture {
  static TabbarDTO base() {
    return TabbarDTO.fromJson(_baseJson);
  }

  static final Map<String, dynamic> _baseJson = {
    'id': 123,
    'name': 'fake name',
  };
}
