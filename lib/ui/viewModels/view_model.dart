import 'dart:io';
import 'dart:developer' as developer;

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mvvm_getx/data/remote/exceptions/exceptions.dart';
import 'package:mvvm_getx/data/remote/repositories/app_repository_impl.dart';
import 'package:mvvm_getx/data/response/response.dart';

import '../../data/remote/models/model.dart';

class ViewModel extends GetxController {
  final _repo = AppRepositoryImpl();

  Rx<Response<List<Model>>> baseResponse = Response<List<Model>>.loading().obs;

  void getData() async {
    _setData(Response.loading());

    try {
      final data = await _repo.getData();
      _setData(Response.success(data));
    } on SocketException {
      _setData(Response.failure('No Internet Connection'));
    } on BadRequestException {
      _setData(Response.failure('Bad request'));
    } on UnauthorisedException {
      _setData(Response.failure('Unauthorized'));
    } on FetchDataException {
      _setData(Response.failure(
          'An error occurred while communicating with the server'));
    } catch (e) {
      _setData(Response.failure('An unknown error occurred: ${e.toString()}'));
    }
  }

  void _setData(Response<List<Model>> response) {
    baseResponse.value = response;
    developer.log('Posts', name: response.toString());
  }
}
