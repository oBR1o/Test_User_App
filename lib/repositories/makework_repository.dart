import 'package:makework/models/makework_models.dart';




abstract class MakeWorkRepository{

  Future<List<MakeWorkModel>> load();

  Future<void> remove({required int id});
  Future<void> update(MakeWorkModel updatedUser);
  Future<void> add({required String userName, required String email, required String firstName, required String lastName, required String password});
}