import 'package:makework/models/makework_models.dart';

abstract class MakeWorkRepository{
  Future<List<MakeWorkModel>> load();
}