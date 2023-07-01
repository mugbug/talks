import 'package:home/src/features/home/data/data_source/home_rest_data_source.dart';
import 'package:home/src/features/home/data/dtos/home_dto.dart';

class HomeRepository {
  final HomeRestDataSource _homeRestDataSource;

  HomeRepository({
    required HomeRestDataSource homeRestDataSource,
  }) : _homeRestDataSource = homeRestDataSource;

  Future<HomeDTO> fetch({
    required int id,
  }) async {
    return await _homeRestDataSource.fetch(id: id);
  }
}
