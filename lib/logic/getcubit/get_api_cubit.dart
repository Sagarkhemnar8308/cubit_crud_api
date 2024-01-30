import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc_api/model/getApiModel.dart';
import 'package:crud_bloc_api/repo/getApiRepo.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
part 'get_api_state.dart';

class GetApiCubit extends Cubit<GetApiState> {
  final CrudApiRepo apirepo = CrudApiRepo();
  GetApiCubit() : super(GetApiInitial());
//get
  void getData() async {
    try {
      emit(GetApiLoading());
      var data = await apirepo.fetchData();
      emit(GetApiLoaded(datamodel: data.data ?? []));
      log(data.data.toString());
    } catch (e) {
      print(e);
    }
  }

//post
  void postData(String email, String password) async {
    try {
      emit(GetApiLoading());
      var data = await apirepo.postUser(email: email, password: password);
      emit(GetApiLoaded(datamodel: data.data));
    } catch (e) {
      emit(GetApiError(error: e.toString()));
    }
  }

//update
  Future<void> updateUser(String id, String email, String password) async {
    try {
      emit(EditUserloading());
      var data = await apirepo.updateuser(id: id,email: email, password: password);
      emit(EditUserloaded());
    } catch (e) {
      emit(GetApiError(error: e.toString()));
    }
  }

//delete
  void deleteUser(String id) async {
    try {
      emit(GetApiLoading());
      apirepo
          .deleteUser(id)
          .then((value) => getData())
          .catchError((e) => {print(e)});
    } catch (e) {}
  }
}
