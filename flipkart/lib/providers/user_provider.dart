import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_first_app/api_services/firebase_api.dart';
import 'package:my_first_app/api_services/user_service.dart';
import 'package:my_first_app/models/api_usermodel_p.dart';
import 'package:my_first_app/models/api_users.dart';
import 'package:my_first_app/todo_application/db_helper.dart';
import 'package:my_first_app/todo_application/todo_model.dart';

class UserProvider extends ChangeNotifier {
  final service = UserService();
  List<ApiUser> apiUserList = [];

  //for pagination
  List<ApiUserModelP> photos = [];

  Future<void> getApiUser() async {
    final response = await service.getUsersApi();

    if (response != null) {
      apiUserList = response;
    }
    notifyListeners();
  }

  //post
  String? _title;
  // String? get gettitle => _title;
  set setTitle(String? val) => _title = val;

  String? _body;
  set setbody(String? value) => _body = value;

  Future<void> createPost(
      // {
      // required String title,
      // required String body,
      // required String userId,
      // }
      ) async {
    try {
      Map<String, dynamic> data = {
        "title": _title,
        "body": _body,
        "userId": "userId"
      };
      await service.createPostApi(data);
    } catch (e, s) {
      log(e.toString(), name: 'error catch createPost', stackTrace: s);
    }
  }

  //ToDo Provider

  List<TodoModel> todos = [];

  Future<int> getTodos({int limit = 10, int offset = 0}) async {
    final response = await DBHelper.instance.getTodos(limit, offset);

    offset == 0 ? todos = response : todos += response;

    todos = response;
    notifyListeners();
    return response.length;
  }

  //Firebasecloud  storage todo list
  List<TodoModel> fireTodos = [];

  Future<int> getFireTodos({int limit = 10, int offset = 0}) async {
    final response = await FirebaseApi.instance.getTodos();
    List<TodoModel> tempData = List.from(response
        .map((e) => TodoModel.fromJson(e.data() as Map<String, dynamic>)));

    fireTodos = tempData;

    notifyListeners();
    return response.length;
  }

  // for Pagination
  Future<int> getPhotos({int limit = 10, int offset = 1}) async {
    final response = await service.getPhotosApi(limit, offset);
    // log(response.toString(), name: 'getPhotos');

    List<ApiUserModelP> tempList = List<ApiUserModelP>.from(
      response.map(
        (e) => ApiUserModelP.fromjson(e),
      ),
    );
    offset == 1 ? photos = tempList : photos += tempList;
    notifyListeners();
    return tempList.length;
  }
}
