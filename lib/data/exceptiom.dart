class AppException implements Exception {
  final messages;

  final profile;

  AppException.AppException({this.messages, this.profile});

  @override
  String toString() {
    return '$profile$messages';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String s, {String? messages})
      : super.AppException(messages: 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(String s, {String? messages}) : super.AppException(messages: "Error");
}






class RequestTimeout extends AppException {
  RequestTimeout(String s, {String? messages}) : super.AppException(messages: 'dsdsd');
}

class ApiException extends AppException {
  ApiException(String s, {String? messages})
      : super.AppException(messages: "Failed to load");
}
