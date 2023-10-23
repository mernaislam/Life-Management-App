import 'package:life_management/models/event.dart';
import 'package:riverpod/riverpod.dart';


class EventNotifier extends StateNotifier<List<EventModel>>{
  EventNotifier() : super([]);

  void addEvent(EventModel event){
    state = [...state, event];
  }

  void deleteEvent(EventModel event){
    state = [...state.where((element) => element != event)];
  }
}


final eventList = StateNotifierProvider<EventNotifier,List<EventModel>>((ref) => EventNotifier());