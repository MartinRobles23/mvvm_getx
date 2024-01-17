// ignore_for_file: prefer_typing_uninitialized_variables

class Exeptions implements Exception {
  final _message;
  final _prefix;

  Exeptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends Exeptions {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends Exeptions {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends Exeptions {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}

class InvalidInputException extends Exeptions {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
