class ServerException implements Exception {
  //final ErrorMessageModel errorMessageModel;
  final String errorMessage;

  const ServerException({
    //required this.errorMessageModel,
    required this.errorMessage,
  });
}

class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({
    required this.message,
  });
}
