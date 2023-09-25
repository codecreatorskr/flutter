import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_first_app/api_services/user_service.dart';
// import 'package:my_first_app/api_services/random_user_services.dart';
import 'package:my_first_app/models/api_users.dart';

class UserProvider extends ChangeNotifier {
  final service = UserService();
  List<ApiUser> apiUserList = [];

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
}
