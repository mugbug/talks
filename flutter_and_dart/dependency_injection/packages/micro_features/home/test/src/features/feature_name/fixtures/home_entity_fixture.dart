// ignore_for_file: avoid_classes_with_only_static_members

import 'package:home/src/features/home/business_logic/entities/home_entity.dart';

class HomeEntityFixture {
  static HomeEntity base() {
    return const HomeEntity(name: 'some mocked name');
  }
}
