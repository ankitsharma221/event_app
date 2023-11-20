// states.dart
import 'package:equatable/equatable.dart';
import 'package:task1/model/model.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class SearchState extends EventState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Event> events;

  SearchLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}
