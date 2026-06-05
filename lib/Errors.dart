class InitializationException implements Exception {
  String message;
  bool completionStatus;

  InitializationException({
    required this.message,
    required this.completionStatus,
  });

  @override
  String toString() {
    return "InitializationException: $message";
  }
}

class DuplicateEntityException implements Exception {
  String message;
  bool completionStatus;

  DuplicateEntityException({
    required this.message,
    required this.completionStatus,
  });

  @override
  String toString() {
    return "InitializationException: $message";
  }
}
