import 'package:http/http.dart';

import '../../data/dtos/profile_dto.dart';

class ProfileRestDataSource {
  final Client _client;

  ProfileRestDataSource({
    required Client client,
  }) : _client = client;

  Future<ProfileDTO> fetch({
    required int id,
  }) async {
    final Uri uri = Uri.parse('https://google.com');

    // final response = await _client.get(
    //   uri,
    // );

    await Future.delayed(const Duration(seconds: 2));

    return ProfileDTO(id: id, name: 'Mocked result');
    // return ProfileDTO.fromJson(jsonDecode(response.body));
  }
}
