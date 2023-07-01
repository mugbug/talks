// ignore_for_file: avoid_classes_with_only_static_members

import 'package:tabbar/src/features/tabbar/business_logic/entities/tabbar_entity.dart';

class TabbarEntityFixture {
  static TabbarEntity base() {
    return const TabbarEntity(name: 'some mocked name');
  }
}
