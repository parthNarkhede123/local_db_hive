part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeInitialSuccess extends HomeState {
  final GetData getData;

  HomeInitialSuccess({required this.getData});
}

class HomeInitialFailure extends HomeState {
  final GetData getData;

  HomeInitialFailure({required this.getData});
}

class HomeInitialLoading extends HomeState {}

class ToDoPutLoading extends HomeState {}

class ToDoPutSuccess extends HomeState {}

class ToDoPutFailure extends HomeState {}
