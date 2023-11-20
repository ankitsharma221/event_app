// events.dart
import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends EventEvent {}

class SearchTextChanged extends EventEvent {
  final String query;

  const SearchTextChanged(this.query);

  @override
  List<Object> get props => [query];
}
