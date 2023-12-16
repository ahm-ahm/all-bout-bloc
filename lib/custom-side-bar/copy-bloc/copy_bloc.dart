import 'package:bloc_text_feild/custom-side-bar/copy-bloc/copy_events.dart';
import 'package:bloc_text_feild/custom-side-bar/copy-bloc/copy_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopyBloc extends Bloc<MainEvent, MainCopyState> {
  CopyBloc() : super(InitialCopyState());
  @override
  void onEvent(MainEvent event) {
    super.onEvent(event);
    switch (event) {
      case InitialCopyEvent:
      default:
      // emit()
    }
  }
}
