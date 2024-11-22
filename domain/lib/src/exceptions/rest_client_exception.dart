abstract base class RestClientException implements Exception {
  final String message;
  final int? statusCode;

  const RestClientException({required this.message, this.statusCode});
}

abstract base class RestClientExceptionWithCause extends RestClientException {
  const RestClientExceptionWithCause({
    required super.message,
    required this.cause,
    super.statusCode,
  });

  final Object? cause;
}

final class ClientException extends RestClientException {
  const ClientException({
    required super.message,
    super.statusCode,
    this.cause,
  });

  final Object? cause;

  @override
  String toString() => 'ClientException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

final class CustomServerException extends RestClientException {
  const CustomServerException({
    required super.message,
    required this.error,
    super.statusCode,
  });

  final String error;

  @override
  String toString() => 'CustomServerException('
      'message: $message, '
      'error: $error, '
      'statusCode: $statusCode, '
      ')';
}

final class WrongResponseTypeException extends RestClientException {
  const WrongResponseTypeException({
    required super.message,
    super.statusCode,
  });

  @override
  String toString() => 'WrongResponseTypeException('
      'message: $message, '
      'statusCode: $statusCode, '
      ')';
}

final class ConnectionException extends RestClientExceptionWithCause {
  const ConnectionException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'ConnectionException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

final class InternalServerException extends RestClientExceptionWithCause {
  const InternalServerException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'InternalServerException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}
