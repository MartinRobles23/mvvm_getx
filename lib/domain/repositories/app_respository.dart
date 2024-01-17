import 'package:mvvm_getx/data/remote/models/model.dart';

abstract class AppRepository {
  Future<List<Model>> getData();
}
