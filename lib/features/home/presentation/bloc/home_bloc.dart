import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_db/features/home/data/models/get_data_response.dart';
import 'package:local_db/features/home/data/models/todo_hive_model.dart';
import 'package:local_db/features/home/domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<InitialEvent>(initialEvent);
    on<ToDoPutEvent>(toDoPutEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitialLoading());
    final repository = HomeUseCase();
    final results = await repository.invoke();

    if (results.isLeft) {
      emit(HomeInitialFailure(getData: await fetchTodos()));
    } else {
      try {
        final model = GetData.fromJson(results.right);
        await saveTodos(model);

        emit(HomeInitialSuccess(getData: await fetchTodos()));
      } catch (e) {
        print(e);
        emit(HomeInitialFailure(getData: await fetchTodos()));
      }
    }
  }

  Future<void> saveTodos(GetData data) async {
    var box = await Hive.openBox<HiveTodo>('todosBox');

    await box.clear();

    for (var todo in data.todos ?? []) {
      if (todo != null) {
        var hiveTodo = HiveTodo.fromTodo(todo);
        await box.put(hiveTodo.id, hiveTodo);
      }
    }
  }

  Future<GetData> fetchTodos() async {
    var box = await Hive.openBox<HiveTodo>('todosBox');

    List<HiveTodo> todos = box.values.toList();

    GetData getData = GetData(
      todos: todos.map((todo) {
        return Todo(
          id: todo.id,
          todo: todo.todo,
          completed: todo.completed,
          userId: todo.userId,
        );
      }).toList(),
      total: todos.length,
      skip: 0,
      limit: todos.length,
    );

    return getData;
  }

  FutureOr<void> toDoPutEvent(
      ToDoPutEvent event, Emitter<HomeState> emit) async {
    emit(ToDoPutLoading());
    final repository = HomeUseCasePut();
    final results = await repository.invoke(event.id, event.isComplete);
    GetData getData = await fetchTodos();
    getData.todos?[event.id - 1].completed = !event.isComplete;
    emit(HomeInitialSuccess(getData: await fetchTodos()));
  }
}
