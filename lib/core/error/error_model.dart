class ErrorModel {
  int status;
  String errorMessage;
  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(dynamic jsonData) {
    return ErrorModel(
      status: jsonData['status'],
      errorMessage: jsonData['ErrorMessage'],
    );
  }
}
