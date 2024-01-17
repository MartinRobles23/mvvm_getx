import 'package:mvvm_getx/config/constants/constants.dart';
import 'package:mvvm_getx/data/remote/api/api_service.dart';
import 'package:mvvm_getx/domain/datasources/base_api_service.dart';
import 'package:mvvm_getx/data/remote/models/model.dart';
import 'package:mvvm_getx/domain/repositories/app_respository.dart';

class AppRepositoryImpl implements AppRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<List<Model>> getData() async {
    try {
      dynamic response = await _apiService.getResponse(Constants.POSTS);

      if (response is List) {
        List<Model> jsonData =
            response.map((item) => Model.fromJson(item)).toList();
        return jsonData;
      } else {
        throw const FormatException('Received data is not a list');
      }
    } catch (e) {
      rethrow;
    }
  }
}
