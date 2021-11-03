import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:task_analysis/helpers/db_helper.dart';
import 'package:task_analysis/models/user_model.dart';
import 'package:task_analysis/network_module/api_response.dart';

class AuthProvider with ChangeNotifier {
  List<User> users = [];

  late ApiResponse<List<User>> _users;

  late ApiResponse<User> _user;
  ApiResponse<User> get user => _user;

  // ApiResponse<User> get users => _user;
  // ApiResponse< List<User>>

  void registerUser() async {
    final user = User(name: "madhan", gender: "male");
    try {
      await TasksAnalysisDatabase.instance.createUser(user);
    } catch (e) {
      print(e);
      print('something went wrong ');
    }
  }

  void getRegisteredUsers() async {
    List<User> usersList = await TasksAnalysisDatabase.instance.readAllUsers();
    print("get");
    users = usersList;
    notifyListeners();
  }

  Future loginUser() async {
    try {
      _user = ApiResponse.loading('loading...');
      notifyListeners();
      User user =
          await TasksAnalysisDatabase.instance.authenticateUser('madhan');

      _user = ApiResponse.completed(user);
      notifyListeners();
    } catch (e) {
      _user = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  void logoutUser() {}
}
