import 'package:home/src/features/home/data/repositories/home_repository.dart';

import '../../data/dtos/home_dto.dart';
import '../entities/home_entity.dart';

/// UseCase - The "Brain" of the architecture
///
/// It's the component where we'll process all the data we need,
/// apply business logic to it to create an object that is easy to use
/// on the presentation layer
///
/// In practice, here is where you will get 1+ DTOs from 1+ repositories
/// and condense it all into a single entity
///
/// For instance, let's say we have an API that we can fetch a user's name
/// and another API that we can fetch a user's birth date.
/// We'll use this information to present in a screen the following text:
/// "User André Katz was born in 15/09/1995"
///
/// To do this, we will return a simple entity, that will enable us to do this:
/// "User {entity.name} was born in {entity.date}"

class HomeUseCase {
  final HomeRepository _repository;

  const HomeUseCase({
    required HomeRepository repository,
  }) : _repository = repository;

  Future<HomeEntity> fetchHome() async {
    final homeDTO = await _repository.fetch(
      id: 1,
    );

    return _convertHomeDtoToEntity(
      homeDTO: homeDTO,
    );
  }

  HomeEntity _convertHomeDtoToEntity({
    required HomeDTO homeDTO,
  }) {
    final entity = HomeEntity(
      name: homeDTO.name,
    );
    return entity;
  }
}
