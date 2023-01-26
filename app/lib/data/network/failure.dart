class Failure {
  String code; // 200 or 400
  int results; // error or success

  Failure(this.code, this.results);
}
