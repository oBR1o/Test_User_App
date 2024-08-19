import 'package:makework/models/makework_models.dart';
import 'package:makework/repositories/makework_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();

final String endpoint = dotenv.env['ENDPOINT']!;

class MakeWorkRepoFromDB extends MakeWorkRepository {
  List<MakeWorkModel> users = [];
  
  @override
  Future<List<MakeWorkModel>> load() async {
    final response = await dio.get(
      "$endpoint/api/user/user/",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data
          .map<MakeWorkModel>((user) => MakeWorkModel.fromJson(user))
          .toList();
      users = data;
      return users;
    } else {
      return users;
    }
  }

  @override
  Future<void> remove({required int id}) async {}

  @override
  Future<void> update(MakeWorkModel updatedUser) async {}

  @override
  Future<void> add(
      {required String userName,
      required String email,
      required String firstName,
      required String lastName}) async {}
}
