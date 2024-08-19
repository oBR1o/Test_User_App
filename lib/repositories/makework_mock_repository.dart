import 'package:makework/models/makework_models.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkMockRepository extends MakeWorkRepository{

  List<MakeWorkModel> users = [
      const MakeWorkModel(1, 'test1', 'test1@test.com', 'Firstname1', 'Lastname', true, '', ''),
      const MakeWorkModel(2, 'test2', 'test2@test.com', 'Firstname2', 'Lastname', true, '', ''),
      const MakeWorkModel(3, 'test3', 'test3@test.com', 'Firstname3', 'Lastname', true, '', ''),
    ];
    
    int lastId = 3;
  @override
  Future<List<MakeWorkModel>> load() async {
    await Future.delayed(const Duration(seconds: 1));
    return users;
  }

  @override
  Future<void> remove({required int id}) async {
    await Future.delayed(const Duration(seconds: 0));
    users.removeWhere((user) => user.id == id);
  }

  @override
  Future<void> update(MakeWorkModel updatedUser) async {
    await Future.delayed(const Duration(seconds: 0));
    final index = users.indexWhere((user) => user.id == updatedUser.id);
    users[index] = updatedUser;
  }

  @override
  Future<void> add({required String userName, required String email, required String firstName, required String lastName}) async {
    await Future.delayed(const Duration(seconds: 0));
    int id = lastId + 1;
    lastId++;
    MakeWorkModel newElement = MakeWorkModel(id, userName, email, firstName, lastName, true, '', '');
    users.add(newElement);
  }
}