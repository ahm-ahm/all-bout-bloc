// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
//
// import '../../data-events/data_event.dart';
// import '../../data-states/data_state.dart';
//
// class DataBloc extends Bloc<DataEvent, DataState> {
//   final Dio dio = Dio();
//
//   DataBloc():super(initialState); // Dio instance for making network requests
//
//   @override
//   DataState get initialState => InitialDataState();
//
//   @override
//   Stream<DataState> mapEventToState(DataEvent event) async* {
//     if (event is FetchDataEvent) {
//       yield InitialDataState();
//
//       try {
//         // Make a GET request using dio
//         Response response = await dio.get('https://api.example.com/data');
//
//         // Process the response and yield the appropriate state
//         if (response.statusCode == 200) {
//           yield LoadedDataState(response.data);
//         } else {
//           yield ErrorDataState('Failed to load data. Status code: ${response.statusCode}');
//         }
//       } catch (e) {
//         yield ErrorDataState('Failed to load data. Error: $e');
//       }
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Utils/general-helpers/internet_error.dart';
import '../../../api-service/data-events/data_event.dart';
import '../../../api-service/data-states/data_state.dart';
import '../../../api-service/repository/get_service.dart';
import '../models/todo.dart';

///========================= EXAMPLE 2

class MyDataBloc extends Cubit<DataEvent> {
  MyDataBloc() : super(Initial());
  final webService = WebServices.instance;

  getData() async {
    if (state is Data) return;
    emit(Loading());
    try {
      dynamic d = await webService.getData();
      emit(Data(data: d));
    } on DioException catch (e) {
      emit(Error(exception: Exception(getDioError(e))));
    }
  }
}

///========================= EXAMPLE 3
class TodoBloc extends Bloc<DataEvent, DataState> {
  final WebServices _userRepository = WebServices.instance;

  TodoBloc() : super(InitialDataState()) {
    on<Initial>((event, emit) async {
      emit(InitialDataState());
      try {
        List<Todo> d = await _userRepository.getData();
        emit(LoadedDataState(d));
      } on DioException catch (e) {
        emit(ErrorDataState(getDioError(e)));
      }
    });
  }
}
