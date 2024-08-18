import 'package:makework/models/makework_models.dart';

abstract class MakeWorkRepository{
  Future<List<MakeWorkModel>> load();
  Future<void> remove({required int id});
  Future<void> update(MakeWorkModel updatedUser);
}