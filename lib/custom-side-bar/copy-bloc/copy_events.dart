sealed class MainEvent {}

class InitialCopyEvent extends MainEvent {}

class CopyEvent extends MainEvent {
  dynamic rowObject;
  CopyEvent(this.rowObject);
}
