//import 'dart:collection';
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:covid_watcher/map/dropdown_date_filter.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import '../models/building_event_model.dart';
//import '../service/firebase_services.dart';
//
//final eventsProvider = StateNotifierProvider.autoDispose<EventNotifier>((ref) {
//  /// A list of new covid events
//  final newCovidEvents = ref.watch(covidCasesProvider);
//
//  if (newCovidEvents.data != null) {
//    if (newCovidEvents.data.value != null) {
//      print(
//          '----------------list of events received in eventsProvider---------------------');
//      newCovidEvents.data.value.forEach((element) {
//        print(element.doc.data()['building']);
//      });
//    }
//  }
//
//  /// A list of new sanitation events
////  final newSanitationEvents = ref.watch(sanitationCasesProvider);
//
//  EventNotifier eventNotifier = EventNotifier();
//  ref.maintainState = true;
//
//  /// Process [docChanges], there might be [removed] or [added] [docChanges]
//  /// TODO (For now not implementing modified elements)
//  if (newCovidEvents.data != null) {
//    if (newCovidEvents.data.value != null) {
////      print(
////          'event controller - new items: ${newCovidEvents.data.value.length}');
//      newCovidEvents.data.value.forEach((element) {
////        print('processing: ${element.doc.data()['building']}');
//        if (element.type == DocumentChangeType.added) {
////          print('adding event');
//          eventNotifier.state.addEvent(
//              BuildingEventModel.fromDocumentSnapshot(element.doc, type: true));
//        } else if (element.type == DocumentChangeType.removed) {
////          print('removing event: ${element.doc.data()['building']}');
//          eventNotifier.state.removeEvent(
//              BuildingEventModel.fromDocumentSnapshot(element.doc, type: true));
//        }
//      });
//    }
//  }
//
////  if (newSanitationEvents.data != null) {
////    if (newSanitationEvents.data.value != null) {
////      newSanitationEvents.data.value.forEach((element) {
////        if (element.type == DocumentChangeType.added) {
////          eventNotifier.state.addEvent(BuildingEventModel.fromDocumentSnapshot(
////              element.doc,
////              type: false));
////        } else if (element.type == DocumentChangeType.removed) {
////          eventNotifier.state.removeEvent(
////              BuildingEventModel.fromDocumentSnapshot(element.doc,
////                  type: false));
////        }
////      });
////    }
////  }
//
//  /// Filter by Date
//  final filter = ref.watch(filterDateProvider).state;
//
//  if (filter != null && filter != '') {
//    DateTime filterDateTime;
//
//    switch (filter) {
//      case 'Last Day':
//        filterDateTime = DateTime.now().subtract(const Duration(days: 1));
//        break;
//      case 'Last Week':
//        filterDateTime = DateTime.now().subtract(const Duration(days: 7));
//        break;
//      case 'Last 2 Weeks':
//        filterDateTime = DateTime.now().subtract(const Duration(days: 14));
//        break;
//      default:
//        filterDateTime = DateTime.now().subtract(const Duration(days: 30));
//    }
//
//    final filteredEvents = EventNotifier();
//    for (int i = 0; i < eventNotifier.state.events.length; i++) {
//      if (eventNotifier.state.events[i].timestamp.isAfter(filterDateTime)) {
//        filteredEvents.state.addEvent(eventNotifier.state.events[i]);
//      }
//    }
//    print(
//        '----------------list of events provide in eventsProvider---------------------');
//    eventNotifier.state.events.forEach((element) {
//      print(element.buildingName);
//    });
//    return filteredEvents;
//  } else {
//    print(
//        '----------------list of events provide in eventsProvider---------------------');
//    eventNotifier.state.events.forEach((element) {
//      print(element.buildingName);
//    });
//
//    return eventNotifier;
//  }
//});
//
//class EventNotifier extends StateNotifier<EventController> {
//  // ignore: always_specify_types
//  EventNotifier() : super(EventController());
//}
//
//class EventController {
//  EventController();
//
//  List<BuildingEventModel> _events = [];
//  UnmodifiableListView<BuildingEventModel> get events =>
//      UnmodifiableListView(_events);
//
//  void addEvent(BuildingEventModel newItem) {
//    _events.add(newItem);
//  }
//
//  set setEvents(List<BuildingEventModel> newItems) {
//    _events = newItems;
//  }
//
//  void removeEvent(BuildingEventModel newItem) {
//    print('removing: ${newItem.buildingName}');
//    _events.remove(newItem);
//    print('now list is: ');
//    _events.forEach((element) {
//      print(element.buildingName);
//    });
//  }
//}
