import 'package:http/http.dart';

import '../../data/dtos/tabbar_dto.dart';

class TabbarRestDataSource {
  final Client _client;

  TabbarRestDataSource({
    required Client client,
  }) : _client = client;

  Future<TabbarDTO> fetch({
    required int id,
  }) async {
    final Uri uri = Uri.parse('https://google.com');

    // final response = await _client.get(
    //   uri,
    // );

    await Future.delayed(const Duration(seconds: 2));

    return TabbarDTO(id: id, name: 'Mocked result');
    // return TabbarDTO.fromJson(jsonDecode(response.body));
  }
}
