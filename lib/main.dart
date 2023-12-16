import 'package:bloc_text_feild/custom_text_feild.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Home-screen/data-bloc/data_bloc.dart';
import 'Screens/Home-screen/view/home_screen.dart';
import 'custom-drop-down/custom_drop_down.dart';
import 'custom-side-bar/custom_side_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => TextFieldCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => SideBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => TodoBloc(),
          ),
          BlocProvider(
            create: (_) => DropDownBloc(),
          ),
        ],
        // child: const MyHomePage(title: 'Flutter Demo Home Page'),
        child: HomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hintText: "Enter name",
                  controller: nameTextEditingController,
                  onChange: (String? s) {
                    if (s != null && s.length <= 5) {
                      print('called-----------------------$s');
                    }
                  },
                  validator: (String? value) {
                    if (value != null && !value.contains("@")) {
                      return "Please enter a valid email!";
                    } else {
                      return "";
                    }
                    return null;
                  },
                ),
                BlocBuilder<TextFieldCubit, TextFieldStates>(
                    buildWhen: (pre, next) {
                  return pre.nameState != next.nameState;
                }, builder: (context, state) {
                  return Text(state.nameState == null
                      ? ""
                      : state.nameState.toString());
                }),
                SizedBox(height: 20),
                BlocBuilder<TextFieldCubit, TextFieldStates>(
                    buildWhen: (pre, next) {
                  return pre.isShowing != next.isShowing;
                }, builder: (context, state) {
                  return CustomTextField(
                    validator: (String? value) {
                      if (value == null) {
                        return "Password must not be empty";
                      }
                    },
                    isPasswordObscured: state.isShowing ?? true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print(state.isShowing.toString());
                        BlocProvider.of<TextFieldCubit>(context)
                            .showingPassword(
                                state.isShowing == true ? false : true);
                      },
                      child: Icon(state.isShowing == true
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: "Enter Password",
                    controller: passwordTextEditingController,
                  );
                }),
                BlocBuilder<TextFieldCubit, TextFieldStates>(
                    buildWhen: (pre, next) {
                  return pre.passwordState != next.passwordState;
                }, builder: (context, state) {
                  return Text(state.passwordState == null
                      ? ""
                      : state.passwordState.toString());
                }),
                const SizedBox(height: 20),

                /// remember me
                BlocBuilder<RememberMeBloc, RememberMeState>(
                    buildWhen: (preS, nextS) {
                  return preS.isChecked != nextS.isChecked;
                }, builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                            title: const Text('Remeber me'),
                            value: state.isChecked ?? false,
                            onChanged: (bool? v) {
                              BlocProvider.of<RememberMeBloc>(context)
                                  .rememberMe(v);
                            }),
                      ),
                    ],
                  );
                }),

                ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        if (nameTextEditingController.text.isEmpty) {
                          BlocProvider.of<TextFieldCubit>(context)
                              .nameError("Name must not be empty");
                        } else if (passwordTextEditingController.text.isEmpty) {
                          BlocProvider.of<TextFieldCubit>(context)
                              .passwordError("Passwrod must not be empty");
                        }
                      }
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///=========================textfield states
class TextFieldCubit extends Cubit<TextFieldStates> {
  TextFieldCubit()
      : super(const TextFieldStates(
          nameState: "",
          passwordState: "",
          isShowing: true,
          isChecked: false,
        ));

  showingPassword(bool isShowing) {
    emit(TextFieldStates(isShowing: isShowing));
  }

  nameError(String isShowing) {
    emit(TextFieldStates(nameState: isShowing));
  }

  passwordError(String passwordError) {
    emit(TextFieldStates(passwordState: passwordError));
  }

  rememberMe(bool? isRemembered) {
    emit(TextFieldStates(isChecked: isRemembered));
  }
}

class TextFieldStates extends Equatable {
  final String? nameState;
  final String? passwordState;
  final bool? isShowing;
  final bool? isChecked;

  const TextFieldStates(
      {this.nameState, this.passwordState, this.isChecked, this.isShowing});

  @override
  List<Object?> get props => [
        nameState,
        passwordState,
        isShowing,
        isChecked,
      ];
}

///=========================RememberMe state
class RememberMeBloc extends Cubit<RememberMeState> {
  RememberMeBloc() : super(const RememberMeState(isChecked: false));

  rememberMe(bool? isRemembered) {
    emit(RememberMeState(isChecked: isRemembered));
  }
}

class RememberMeState extends Equatable {
  final bool? isChecked;

  const RememberMeState({this.isChecked});

  @override
  List<Object?> get props => [
        isChecked,
      ];
}
