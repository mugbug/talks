import 'package:tabbar/src/features/tabbar/data/data_source/tabbar_rest_data_source.dart';
import 'package:tabbar/src/features/tabbar/data/dtos/tabbar_dto.dart';

class TabbarRepository {
  final TabbarRestDataSource _tabbarRestDataSource;

  TabbarRepository({
    required TabbarRestDataSource tabbarRestDataSource,
  }) : _tabbarRestDataSource = tabbarRestDataSource;

  Future<TabbarDTO> fetch({
    required int id,
  }) async {
    return await _tabbarRestDataSource.fetch(id: id);
  }
}
