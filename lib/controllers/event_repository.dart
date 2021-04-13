import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/building_event_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../map/dropdown_date_filter.dart';
import '../models/building_event_model.dart';
import '../service/firebase_services.dart';

final eventRepositoryProvider = StateProvider<List<BuildingEventModel>>((ref) {
  List<BuildingEventModel> events = [];
  return events;
});

final eventsControllerProvider =
    StateProvider.autoDispose<List<BuildingEventModel>>((ref) {
  /// A list of new covid events
  final newCovidEvents = ref.watch(covidCasesProvider);

  /// A list of new sanitation events
  final newSanitationEvents = ref.watch(sanitationCasesProvider);

  /// Repository to store the [BuildingEvent]s
  final eventsRepository = ref.watch(eventRepositoryProvider).state;

  //  print(
//      '----------------list of events received in eventsProvider----------------');
//  if (newCovidEvents.data != null) {
//    if (newCovidEvents.data.value != null) {
//      for (final DocumentChange element in newCovidEvents.data.value) {
//        print(element.doc.data()['building']);
//      }
//    }
//  }
//
//  if (newSanitationEvents.data != null) {
//    if (newSanitationEvents.data.value != null) {
//      for (var element in newSanitationEvents.data.value) {
//        print(element.doc.data()['building']);
//      }
//    }
//  }

  /// Process [docChanges], there might be [removed] or [added] [docChanges]
  /// TODO (For now not implementing modified elements)
  if (newCovidEvents.data != null) {
    if (newCovidEvents.data.value != null) {
      for (final event in newCovidEvents.data.value) {
//        print(event.doc.data()['building']);
        if (event.type == DocumentChangeType.added) {
          /// If id is already in repository is a duplicate -> skip!
          if (-1 !=
              eventsRepository.indexWhere(
                  (element) => event.doc.data()['id'] == element.id)) {
//            print('skipping: ${event.doc.data()['building']}');
            continue;
          }
//          print('add');
          eventsRepository.add(
              BuildingEventModel.fromDocumentSnapshot(event.doc, type: true));
//          print('first name: ${eventsRepository.first.buildingName}');
        } else if (event.type == DocumentChangeType.removed) {
//          print('remove');
          eventsRepository
              .removeWhere((item) => item.id == event.doc.data()['id']);
        }
      }
    }
  }

  if (newSanitationEvents.data != null) {
    if (newSanitationEvents.data.value != null) {
      for (final event in newSanitationEvents.data.value) {
        if (event.type == DocumentChangeType.added) {
          if (-1 !=
              eventsRepository.indexWhere(
                  (element) => event.doc.data()['id'] == element.id)) {
            continue;
          }
          eventsRepository.add(
              BuildingEventModel.fromDocumentSnapshot(event.doc, type: false));
        } else if (event.type == DocumentChangeType.removed) {
          eventsRepository
              .removeWhere((item) => item.id == event.doc.data()['id']);
        }
      }
    }
  }

  /// Filter by Date
  final filter = ref.watch(filterDateProvider).state;
  if (filter != null && filter != '') {
    DateTime filterDateTime;

    switch (filter) {
      case 'Last Day':
        filterDateTime = DateTime.now().subtract(const Duration(days: 1));
        break;
      case 'Last Week':
        filterDateTime = DateTime.now().subtract(const Duration(days: 7));
        break;
      case 'Last 2 Weeks':
        filterDateTime = DateTime.now().subtract(const Duration(days: 14));
        break;
      default:
        filterDateTime = DateTime.now().subtract(const Duration(days: 30));
    }

    List<BuildingEventModel> filterList = [];
    for (int i = 0; i < eventsRepository.length; i++) {
      if (eventsRepository[i].timestamp.isAfter(filterDateTime)) {
        filterList.add(eventsRepository[i]);
      }
    }
//    print(
//        '----------------list of events provided in eventsProvider----------------');
//    for (var element in filterList) {
//      print(element.buildingName);
//    }
    return filterList;
  } else {
//    print(
//        '----------------list of events provided in eventsProvider----------------');
//    for (var element in eventsRepository) {
//      print(element.buildingName);
//    }
    return eventsRepository;
  }
});
