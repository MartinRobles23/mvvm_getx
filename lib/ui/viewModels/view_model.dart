import 'dart:io';
import 'dart:developer' as developer;

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mvvm_getx/data/remote/exceptions/exceptions.dart';
import 'package:mvvm_getx/data/remote/repositories/app_repository_impl.dart';
import 'package:mvvm_getx/data/response/reponse_v2.dart';

import '../../data/remote/models/model.dart';

class ViewModel extends GetxController {
  AppRepositoryImpl repo;

  ViewModel(this.repo);

  Rx<ResponseV2<List<Model>>> baseResponse =
      ResponseV2<List<Model>>.loading().obs;

  void getData() async {
    _setData(ResponseV2.loading());

    try {
      final data = await repo.getData();
      _setData(ResponseV2.success(data));
    } on SocketException {
      _setData(ResponseV2.failure(Exception('No Internet Connection')));
    } on BadRequestException {
      _setData(ResponseV2.failure(Exception('Bad request')));
    } on UnauthorisedException {
      _setData(ResponseV2.failure(Exception('Unauthorized')));
    } on FetchDataException {
      _setData(ResponseV2.failure(
        Exception('An error occurred while communicating with the server'),
      ));
    } catch (e) {
      _setData(
        ResponseV2.failure(
            Exception('An unknown error occurred: ${e.toString()}')),
      );
    }
  }

  void _setData(ResponseV2<List<Model>> response) {
    baseResponse.value = response;
    developer.log('Posts', name: response.toString());
  }
}
