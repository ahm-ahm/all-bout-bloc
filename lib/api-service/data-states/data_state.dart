abstract class DataState {}

class InitialDataState extends DataState {}

class LoadedDataState extends DataState {
  final dynamic data;

  LoadedDataState(this.data);
}

class ErrorDataState extends DataState {
  final String error;

  ErrorDataState(this.error);
}