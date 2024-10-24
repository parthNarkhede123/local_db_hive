part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitialEvent extends HomeEvent {}

class ToDoPutEvent extends HomeEvent {
  final int id;
  final bool isComplete;

  ToDoPutEvent({required this.id, required this.isComplete});
}
