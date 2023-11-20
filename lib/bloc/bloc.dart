import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/bloc/event_repo.dart';
import 'package:task1/bloc/events.dart';
import 'package:task1/bloc/states.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc(this.eventRepository) : super(EventInitial()) {
    on<LoadEvent>((event, emit) async {
      emit(EventLoading());
      try {
        final events = await eventRepository.fetchEvents();
        emit(EventLoaded(events));
      } catch (e) {
        emit(EventError('Failed to load events. Please try again.'));
      }
    });

    on<SearchTextChanged>((event, emit) async {
      emit(SearchLoading());
      try {
        final events = await eventRepository.searchEvents(event.query);
        emit(SearchLoaded(events));
      } catch (e) {
        emit(SearchError('Failed to search events. Please try again.'));
      }
    });
  }
}
