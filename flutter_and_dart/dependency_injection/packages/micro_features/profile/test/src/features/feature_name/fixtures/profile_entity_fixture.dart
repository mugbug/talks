// ignore_for_file: avoid_classes_with_only_static_members

import 'package:profile/src/features/profile/business_logic/entities/profile_entity.dart';

class ProfileEntityFixture {
  static ProfileEntity base() {
    return const ProfileEntity(name: 'some mocked name');
  }
}
