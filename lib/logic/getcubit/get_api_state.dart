part of 'get_api_cubit.dart';

// ignore: must_be_immutable
@immutable
sealed class GetApiState {
  List<Datum>? datamodel;
  GetApiState({this.datamodel});
}

// ignore: must_be_immutable
final class GetApiInitial extends GetApiState {
  GetApiInitial({super.datamodel});
}

// ignore: must_be_immutable
class GetApiLoading extends GetApiState {
  GetApiLoading({super.datamodel});
}

// ignore: must_be_immutable
class GetApiLoaded extends GetApiState {
  GetApiLoaded({super.datamodel});
}

class deleteApi extends GetApiState{
  String message;
  deleteApi(this.message);
}

// ignore: must_be_immutable
class GetApiError extends GetApiState {
  String? error;
  GetApiError({this.error});
}

class EditUserloading extends GetApiState{

}

class EditUserloaded extends GetApiState{

}

class EditUserError extends GetApiState{
  String? error;
EditUserError(this.error);
}