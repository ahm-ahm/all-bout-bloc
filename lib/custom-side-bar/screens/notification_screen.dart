import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  final Function(int? selectedIndex) onChange;
  final int groupValue;

  const NotificationScreen(
      {super.key, required this.onChange, required this.groupValue});

  @override
  Widget build(BuildContext context) {
    final notifyProvider = context.read<RadioBloc>();
    notifyProvider.add(RadioInitialEvent());
    return Container(
      color: Colors.white,
      child: BlocBuilder<RadioBloc, RadioStates>(builder: (context, state) {
        if (state is RadioLoadedState) {
          return ListView.builder(
              itemCount: state.models.length,
              itemBuilder: (_, index) {
                final radio = state.models[index];
                return RadioListTile<bool>(
                  title: Text(radio.title),
                  groupValue: radio.selectedIndex,
                  value: true,
                  onChanged: (bool? value) {
                    context
                        .read<RadioBloc>()
                        .add(ToggleRadioEvent(index: index));
                  },
                );
              });
        }
        return const SizedBox();
      }),
    );
  }
}

//=========================== radio bloc
class RadioBloc extends Bloc<RadioEvents, RadioStates> {
  RadioBloc() : super(InitRadioState()) {
    on<RadioInitialEvent>((event, emit) {
      emit(RadioLoadedState(models: radios));
    });
    on<ToggleRadioEvent>((event, emit) {
      final radioModel = radios.firstWhere((element) => element.selectedIndex,
          orElse: () => RadioModel(title: '', selectedIndex: false));
      print('selected model : ${radioModel.title}  index:${event.index}');

      if (radioModel.title.isEmpty) {
        radios[event.index].selectedIndex = true;
        emit(RadioLoadedState(models: radios));
      } else {
        int selectedIndex = radios.indexOf(radioModel);
        radios[selectedIndex].selectedIndex = false;
        radios[event.index].selectedIndex = true;
        emit(RadioLoadedState(models: radios));
      }
    });
  }
}

abstract class RadioEvents {}

class InitRadioEvent extends RadioEvents {}

class RadioInitialEvent extends RadioEvents {}

class ToggleRadioEvent extends RadioEvents {
  int index;

  ToggleRadioEvent({required this.index});
}

//////////////////////////////////////////////////////
abstract class RadioStates {}

class InitRadioState extends RadioStates {}

class RadioLoadedState extends RadioStates {
  List<RadioModel> models;

  RadioLoadedState({required this.models});
}

class ToggleRadioState extends RadioStates {
  int index;

  ToggleRadioState({required this.index});
}

class RadioModel {
  bool selectedIndex;
  String title;

  RadioModel({
    required this.title,
    required this.selectedIndex,
  });
}

final radios = [
  RadioModel(title: 'New Event', selectedIndex: false),
  RadioModel(title: 'Fation Event', selectedIndex: false),
  RadioModel(title: 'Celebrating Event', selectedIndex: false),
  RadioModel(title: 'Annual Event', selectedIndex: false),
  RadioModel(title: 'Annual Dinner', selectedIndex: false),
  RadioModel(title: 'lunch Event', selectedIndex: false),
  RadioModel(title: 'Dinner Event', selectedIndex: false),
  RadioModel(title: 'Night Event', selectedIndex: false),
  RadioModel(title: 'Morning Event', selectedIndex: false),
];
