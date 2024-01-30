import 'dart:convert';
import 'dart:developer';
import 'package:crud_bloc_api/model/deleteApiModel.dart';
import 'package:crud_bloc_api/model/postApiModel.dart';
import "package:http/http.dart" as http;
import 'package:crud_bloc_api/model/getApiModel.dart';

class CrudApiRepo {
  //Get Api
  Future<GetApiModel> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse("http://localhost:4300/getAll"),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var getApiModel = GetApiModel.fromJson(json.decode(response.body));
        log(response.body.toString());
        return getApiModel;
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        return GetApiModel(status: 'error', data: []);
      }
    } catch (e) {
      print("Error: $e");
      return GetApiModel(status: 'error', data: []);
    }
  }

  //post Method
  Future<GetApiModel> postUser({required email, required password}) async {
    try {
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      var res = await http.post(
        Uri.parse("http://localhost:4300/postUser"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (res.statusCode == 200) {
        var postApiModel = GetApiModel.fromJson(json.decode(res.body));
        log(res.body.toString());
        return GetApiModel();
      } else {
        print("Failed to post data. Status code: ${res.statusCode}");
        throw Exception("Failed to post data. Status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error during POST request: $e");
      throw Exception("Error during POST request: $e");
    }
  }

  //delete api
  Future<GetApiModel> deleteUser(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost:4300/deleteUser/$id"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Return meaningful data indicating success
        return GetApiModel(); // You might want to pass some data here if needed
      } else {
        print("Error during DELETE request: ${response.statusCode}");
        throw Exception("Error during DELETE request: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during DELETE request: $e");
      // Re-throw the exception after logging
      throw e;
    }
  }

//update api
  Future<GetApiModel> updateuser(
     { required String id, required String email, required String password}) async {
    try {
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };
      final response = await http.put(
        Uri.parse("http://localhost:4300/updateUser/$id"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Return meaningful data indicating success
        return GetApiModel(); // You might want to pass some data here if needed
      } else {
        print("Error during DELETE request: ${response.statusCode}");
        throw Exception("Error during DELETE request: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during DELETE request: $e");
      // Re-throw the exception after logging
      throw e;
    }
  }
}
