
abstract class DataEvent {}

class Initial extends DataEvent {}

class Loading extends DataEvent {}

class Error extends DataEvent {
  final Exception exception;

  Error({required this.exception});

  @override
  String toString() {
    return 'Exception: ${exception.toString()}';
  }
}

class Data<T> extends DataEvent {
  final T data;

  Data({required this.data});

  @override
  String toString() {
    return 'Data: ${data.toString()}';
  }
}
