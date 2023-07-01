import 'package:http/http.dart';

import '../../data/dtos/home_dto.dart';

class HomeRestDataSource {
  final Client _client;

  HomeRestDataSource({
    required Client client,
  }) : _client = client;

  Future<HomeDTO> fetch({
    required int id,
  }) async {
    final Uri uri = Uri.parse('https://google.com');

    // final response = await _client.get(
    //   uri,
    // );

    await Future.delayed(const Duration(seconds: 2));

    return HomeDTO(id: id, name: 'Mocked result');
    // return HomeDTO.fromJson(jsonDecode(response.body));
  }
}
