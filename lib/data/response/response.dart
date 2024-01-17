import 'package:mvvm_getx/data/response/response_status.dart';

class Response<T> {
  Status? status;
  T? data;
  String? message;

  Response(this.status, this.data, this.message);

  Response.loading() : status = Status.LOADING;

  Response.success(this.data) : status = Status.SUCCESS;

  Response.failure(this.message) : status = Status.FAILURE;

  @override
  String toString() {
    return 'Status: $status \n Message: $message \n Data: $data';
  }
}
