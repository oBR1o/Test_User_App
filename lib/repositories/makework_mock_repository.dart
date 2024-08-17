import 'package:makework/models/makework_models.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkMockRepository extends MakeWorkRepository{
  @override
  Future<List<MakeWorkModel>> load() async {
    return [
      MakeWorkModel(1, 'test1', 'test1@test.com', 'test1', 'test1', true, DateTime.now()),
      MakeWorkModel(2, 'test2', 'test2@test.com', 'test2', 'test2', true, DateTime.now()),
      MakeWorkModel(3, 'test3', 'test3@test.com', 'test3', 'test3', true, DateTime.now()),
      MakeWorkModel(4, 'test4', 'test4@test.com', 'test4', 'test4', true, DateTime.now()),
      MakeWorkModel(5, 'test5', 'test5@test.com', 'test5', 'test5', true, DateTime.now()),
    ];
  }
}