import 'response_status.dart';

class ResponseV2<T> {
  final Status status;
  final T? data;
  final Exception? error;

  ResponseV2._(this.status, this.data, this.error);

  factory ResponseV2.loading() => ResponseV2._(Status.LOADING, null, null);

  factory ResponseV2.success(T data) =>
      ResponseV2._(Status.SUCCESS, data, null);

  factory ResponseV2.failure(Exception error) =>
      ResponseV2._(Status.FAILURE, null, error);

  @override
  String toString() {
    return 'Status: $status \n Error: $error \n Data: $data';
  }
}
