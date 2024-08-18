import 'package:makework/models/makework_models.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkMockRepository extends MakeWorkRepository{
  @override
  Future<List<MakeWorkModel>> load() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      MakeWorkModel(1, 'test1', 'test1@test.com', 'test1First', 'test1Last', true, DateTime.now()),
      MakeWorkModel(2, 'test2', 'test2@test.com', 'test2First', 'test2Last', true, DateTime.now()),
      MakeWorkModel(3, 'test3', 'test3@test.com', 'test3First', 'test3Last', true, DateTime.now()),
    ];
  }
}