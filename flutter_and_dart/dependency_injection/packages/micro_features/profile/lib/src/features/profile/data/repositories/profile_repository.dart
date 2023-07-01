import 'package:profile/src/features/profile/data/data_source/profile_rest_data_source.dart';
import 'package:profile/src/features/profile/data/dtos/profile_dto.dart';

class ProfileRepository {
  final ProfileRestDataSource _profileRestDataSource;

  ProfileRepository({
    required ProfileRestDataSource profileRestDataSource,
  }) : _profileRestDataSource = profileRestDataSource;

  Future<ProfileDTO> fetch({
    required int id,
  }) async {
    return await _profileRestDataSource.fetch(id: id);
  }
}
