import 'package:bloc_text_feild/custom-side-bar/screens/basic_info_screen.dart';
import 'package:bloc_text_feild/custom-side-bar/screens/change_password_screen.dart';
import 'package:bloc_text_feild/custom-side-bar/screens/logout_screen.dart';
import 'package:bloc_text_feild/custom-side-bar/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SideBloc>(context).add(ToggleSideBarInitialEvent());
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SideBloc, SideBarState>(
            builder: (context, sideBarState) {
          if (sideBarState is SideLoadedState) {
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: const BoxDecoration(
                          // color: Colors.red,
                          border: Border(
                              right: BorderSide(width: 3, color: Colors.grey))),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sideBarState.sideBars.length,
                            itemBuilder: (_, index) {
                              final model = sideBarState.sideBars[index];
                              return listTile(
                                title: model.title,
                                icon: model.icon,
                                isSelected: model.isSelected,
                                onTap: () {
                                  context
                                      .read<SideBloc>()
                                      .add(ToggleSideBarEvent(index: index));
                                },
                              );
                            },
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                Expanded(
                  child: getView(
                    models.indexOf(
                      sideBarState.sideBars
                          .firstWhere((element) => element.isSelected == true),
                    ),
                    (int? checkedIndex) {},
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget getView(int index, Function(int?) onChange) {
    switch (index) {
      case 0:
        return const BasicInfoScreen();
      case 1:
        return const ChangePasswordScreen();
      case 2:
        return BlocProvider(
          create: (_) => RadioBloc(),
          child: NotificationScreen(onChange: onChange, groupValue: index),
        );
      case 3:
        return const LogoutScreen();
      default:
        return const BasicInfoScreen();
    }
  }
}

Widget listTile(
    {required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap}) {
  return Container(
    width: 200,
    decoration: BoxDecoration(
        border: Border(
            right: BorderSide(
                width: 3, color: isSelected ? Colors.blue : Colors.grey))),
    child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 12, color: isSelected ? Colors.blue : Colors.grey),
        )),
  );
}

/////================bloc
class SideBloc extends Bloc<SideBarEvent, SideBarState> {
  SideBloc() : super(InitialSideBarState()) {
    on<ToggleSideBarInitialEvent>((event, emit) {
      emit(SideLoadedState(sideBars: models));
    });

    on<ToggleSideBarEvent>((event, emit) {
      int index = event.index;
      models.firstWhere((element) => element.isSelected == true).isSelected =
          false;
      models[index].isSelected = true;
      emit(SideLoadedState(sideBars: models));
    });
  }
}

class Model {
  bool isSelected;
  String title;
  IconData icon;

  Model({required this.title, required this.isSelected, required this.icon});
}

final models = [
  Model(title: "Basic Information", isSelected: true, icon: Icons.info),
  Model(title: "Change Password", isSelected: false, icon: Icons.password),
  Model(title: "Notification", isSelected: false, icon: Icons.notifications),
  Model(title: "Log Out", isSelected: false, icon: Icons.logout),
];

class SideBarState {}

class InitialSideBarState extends SideBarState {}

class SideLoadedState extends SideBarState {
  List<Model> sideBars;

  SideLoadedState({required this.sideBars});
}

class SideBarEvent {}

class ToggleSideBarInitialEvent extends SideBarEvent {}

class ToggleSideBarEvent extends SideBarEvent {
  int index;

  ToggleSideBarEvent({required this.index});
}
