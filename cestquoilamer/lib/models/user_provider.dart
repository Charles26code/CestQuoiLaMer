import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'dart:convert';
import 'package:cestquoilamer/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final String host = 'http://localhost:80';
  List<User> _users = [];
  UnmodifiableListView<User> get users => UnmodifiableListView(_users);
  // Recuperer les donnees dans la base de donnees
  fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('$host/api/users'));
      if (response.statusCode == 200) {
        _users = (json.decode(response.body) as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        notifyListeners();
        return _users;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Ajouter un user dans la base de donn ́ees
  Future<Map?> addUser(String? username, String? mail, String? mdp) async {
    try {
      Map? result = {};
      http.Response response = await http.post(
        Uri.parse('$host/api/users/add'),
        body:
            json.encode({"username": username, "email": mail, "password": mdp}),
        headers: {'Content-type': 'application/json'},
      );
      result.addAll({"statusCode": response.statusCode});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        result.addAll({"message": json['message']});
      }
      if (response.statusCode == 400) {
        Map<String, dynamic> json = jsonDecode(response.body);
        result.addAll({"message": json['error']});
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> login(String? mailusername, String? mdp) async {
    try {
      Map retour = {};
      http.Response response = await http.post(
        Uri.parse('$host/api/users/login'),
        body: json.encode({'mailusername': mailusername, 'password': mdp}),
        headers: {'Content-type': 'application/json'},
      );
      retour.addAll({"statusCode": response.statusCode});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        User monUser = User.fromJson(json['user']);
        retour.addAll({"message": "Connecté !"});
        retour.addAll({"user": monUser});
      }
      if (response.statusCode == 401) {
        Map<String, dynamic> json = jsonDecode(response.body);
        retour.addAll({"message": json['error']});
      }
      return retour;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> changePassword(String? mailusername, String? mdp) async {
    try {
      Map retour = {};
      http.Response response = await http.post(
        Uri.parse('$host/api/users/changepassword'),
        body: json.encode({'mailusername': mailusername, 'password': mdp}),
        headers: {'Content-type': 'application/json'},
      );
      retour.addAll({"statusCode": response.statusCode});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        retour.addAll({"message": json['message']});
      }
      if (response.statusCode == 401) {
        Map<String, dynamic> json = jsonDecode(response.body);
        retour.addAll({"message": json['error']});
      }
      return retour;
    } catch (e) {
      rethrow;
    }
  }
}
