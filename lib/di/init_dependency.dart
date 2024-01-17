import 'package:get/get.dart';
import 'package:mvvm_getx/ui/viewModels/view_model.dart';

class InitDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewModel());
  }
}
