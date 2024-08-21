import 'package:flutter/foundation.dart';
import 'package:makework/models/makework_models.dart';
import 'package:makework/network/dio_client.dart';
import 'package:makework/repositories/makework_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final DioClient _dioClient = DioClient();

final String endpoint = dotenv.env['ENDPOINT']!;

class MakeWorkRepoFromDB extends MakeWorkRepository {
  List<MakeWorkModel> users = [];

  @override
  Future<List<MakeWorkModel>> load() async {
    final response = await _dioClient.dio.get(
      "$endpoint/api/user/user/",
    );
    if (response.statusCode == 200) {
      debugPrint("Response: ${response.data}");
      final Map<String, dynamic> data = response.data;
      final List<dynamic> responseData = data['results'];
      final List<MakeWorkModel> parsedData =
          responseData.map((json) => MakeWorkModel.fromJson(json)).toList();

      parsedData.sort((a, b) => a.date_joined!.compareTo(b.date_joined!));

      users = parsedData;
      print(users);
      print(data);
      return users;
    } else {
      print("Error: ${response.statusCode}");
      return users;
    }
  }

  @override
  Future<void> remove({required int id}) async {
    final response = await _dioClient.dio.delete(
      "$endpoint/api/user/user/$id/",
    );
    if (response.statusCode == 204) {
      debugPrint("Delete Complete: ${response.data}");
    } else {
      debugPrint("Delete Error: ${response.statusCode}");
    }
  }

  @override
  Future<void> update(MakeWorkModel updatedUser) async {
    final response = await _dioClient.dio.patch(
      "$endpoint/api/user/user/${updatedUser.id}/",
      data: {
        "username": updatedUser.username,
        "email": updatedUser.email,
        "first_name": updatedUser.first_name,
        "last_name": updatedUser.last_name,
        "password": "123456789",
        "is_active": true,
      }
    );
    if(response.statusCode == 200){
      debugPrint("Update Complete: ${response.data}");
    }else{
      debugPrint("Update Error: ${response.statusCode}");
    }
  }

  @override
  Future<void> add(
      {required String userName,
      required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    final response = await _dioClient.dio.post(
      "$endpoint/api/user/user/",
      data: {
        "username": userName,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "is_active": true,
      }
    );
    if(response.statusCode == 201){
      debugPrint("Add Complete: ${response.data}");
    }else{
      debugPrint("Add Error: ${response.statusCode}");
    }
  }
}
