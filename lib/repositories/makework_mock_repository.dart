import 'package:makework/models/makework_models.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkMockRepository extends MakeWorkRepository{
  @override
  Future<List<MakeWorkModel>> load() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      MakeWorkModel(1, 'test1', 'test1@test.com', 'Firstname1', 'Lastname', true, DateTime.now()),
      MakeWorkModel(2, 'test2', 'test2@test.com', 'Firstname2', 'Lastname', true, DateTime.now()),
      MakeWorkModel(3, 'test3', 'test3@test.com', 'Firstname3', 'Lastname', true, DateTime.now()),
    ];
  }
}