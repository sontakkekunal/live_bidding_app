class PassModel {
  bool value = false;
  final String msg;
  PassModel({required this.msg});
  @override
  String toString() {
    return value.toString();
  }
}
