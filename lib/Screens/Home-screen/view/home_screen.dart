import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api-service/data-events/data_event.dart';
import '../../../api-service/data-states/data_state.dart';
import '../../../widgets/custom_shimmer_effect.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/my_tile_item.dart';
import '../data-bloc/data_bloc.dart';
import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // NetWorkHelperImpl.instance.get(url: AppUrls.baseUrl + AppUrls.todos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<MyDataBloc>().getData();

    context.read<TodoBloc>().add(Initial());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // body: BlocBuilder<MyDataBloc, DataEvent>(
      //   builder: (context, dataEvent) {
      //     if (dataEvent is Initial) {
      //       return const SizedBox();
      //     } else if (dataEvent is Loading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (dataEvent is Data) {
      //       final list = dataEvent.data as List<Todo>;
      //       return ListView.builder(
      //           itemCount: list.length,
      //           itemBuilder: (_, i) {
      //             return Card(
      //               child: ListTile(
      //                 title: Text(list[i].title.toString()),
      //               ),
      //             );
      //           });
      //     } else if (dataEvent.toString().contains('No internet')) {
      //       return SingleErrorTryAgainWidget(
      //         message: 'Data',
      //         onClick: () {
      //           context.read<MyDataBloc>().getData();
      //         },
      //         bottomMargin: 20,
      //       );
      //     }
      //
      //     return SingleErrorTryAgainWidget(
      //       message: dataEvent
      //           .toString()
      //           .replaceAll('Exception:', '')
      //           .replaceAll('DioError', ''),
      //       onClick: () {
      //         context.read<MyDataBloc>().getData();
      //       },
      //       bottomMargin: 20,
      //     );
      //
      //     // }
      //   },
      // ),
      ///===============================TODO: example2
      body: RefreshIndicator(
        onRefresh: () {
          context.read<TodoBloc>().add(Initial());
          return Future(() => null);
        },
        child: BlocBuilder<TodoBloc, DataState>(builder: (context, dataState) {
          if (dataState is InitialDataState) {
            return const ShimmerWidget();
          } else if (dataState is LoadedDataState) {
            final list = dataState.data as List<Todo>;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  return ListTileItem(title: list[i].title.toString());
                });
          } else if (dataState is ErrorDataState) {
            return SingleErrorTryAgainWidget(
              message: dataState.error.toString(),
              onClick: () {
                context.read<TodoBloc>().add(Initial());
              },
              bottomMargin: 20,
            );
          }

          return const SizedBox();

          // }
        }),
      ),
    );
  }
}
