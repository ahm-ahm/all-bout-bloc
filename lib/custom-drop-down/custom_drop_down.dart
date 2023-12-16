import 'package:bloc_text_feild/custom_text_feild.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _HomePageState();
}

class _HomePageState extends State<CustomDropdown> {
  // define a list of options for the dropdown
  final List<String> _animals = ["Dog", "Cat", "Crocodile", "Dragon"];

  // the selected value
  String? dropdownValue;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dBloc = BlocProvider.of<DropDownBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<DropDownBloc, DropdownStates>(
                        buildWhen: (pre, next) {
                      return pre.firstD != next.firstD;
                    }, builder: (context, state) {
                      print('first d builder:$state');
                      return DropdownButtonFormField(
                        validator: (v) {
                          if (v == null || v!.isEmpty) {
                            return 'select please one option';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 3.0,
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        hint: Text('select option'),
                        dropdownColor: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        value: state.firstD,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        onChanged: (value) => {
                          // cityValue = value!,
                          print(value),
                          dBloc.firstD(value: value)
                        },
                        items: <String>['Tehran', 'Cat', 'Tiger', 'Lion']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      validator: (v) {
                        if (v == null || v!.isEmpty) {
                          return 'select please one option';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<DropDownBloc, DropdownStates>(
                        buildWhen: (pre, next) {
                      return pre.secondD != next.secondD;
                    }, builder: (context, state) {
                      print('second d builder:$state');

                      return DropdownButtonFormField(
                        validator: (v) {
                          if (v == null || v!.isEmpty) {
                            return 'select please one option';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 3.0,
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        hint: Text('select option'),
                        dropdownColor: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        value: state.secondD,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        onChanged: (value) => {
                          // cityValue = value!,
                          print('second value $value'),
                          dBloc.secondD(value: value),
                        },
                        items: <String>['Tehran', 'Cat', 'Tiger', 'Lion']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      validator: (v) {
                        if (v == null || v!.isEmpty) {
                          return 'select please one option';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('validated');
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SecondPage(
                          model: Model(
                              firstD: dBloc.state.firstD,
                              secondD: dBloc.state.secondD),
                        );
                      }));
                    }
                  },
                  child: Text('click')),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownBloc extends Cubit<DropdownStates> {
  DropDownBloc() : super(DropdownStates(firstD: null, secondD: null));

  firstD({String? value}) {
    emit(state.copyWith(firstD: value));
  }

  secondD({String? value}) {
    emit(state.copyWith(secondD: value));
  }
}

class DropdownStates extends Equatable {
  String? firstD;
  String? secondD;
  DropdownStates({this.firstD, this.secondD});

  @override
  List<Object?> get props => [firstD, secondD];

  DropdownStates copyWith({String? firstD, String? secondD}) {
    return DropdownStates(
        firstD: firstD ?? this.firstD, secondD: secondD ?? this.secondD);
  }
}

class SecondPage extends StatelessWidget {
  Model? model;
  SecondPage({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second screen'),
      ),
      body: Column(
        children: [
          Text(model?.firstD ?? 'no value'),
          Text(model?.firstT ?? 'no value'),
          Text(model?.secondD ?? 'no value'),
          Text(model?.secondT ?? 'no value'),
        ],
      ),
    );
  }
}

class Model {
  String? firstD, secondD, firstT, secondT;
  Model({this.firstD, this.secondD, this.firstT, this.secondT});
}
