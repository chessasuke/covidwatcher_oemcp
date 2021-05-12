import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event_model.dart';
import '../providers/heatmap_providers.dart';
import '../services_controller/firebase_firestore_services.dart';

final eventsControllerProvider =
    StateProvider.autoDispose<List<EventModel>>((ref) {
//  print('inside event controller');

  /// A list of new covid events
  final newCovidEvents = ref.watch(covidCasesProvider);

  ///*********** NEW VERSION OF OEMCP DOESNT INCLUDE SANITATION*************

  /// A list of new sanitation events
//  final newSanitationEvents = ref.watch(sanitationCasesProvider);

  /// Repository to store the [BuildingEvent]s
  final eventsRepository = ref.watch(eventRepositoryProvider).state;

  /// Process [docChanges], there might be [removed] or [added] [docChanges]
  /// TODO (For now not implementing modified elements)
  if (newCovidEvents.data != null) {
    if (newCovidEvents.data.value != null) {
//      print(
//          'newCovidEvents.data.value.length: ${newCovidEvents.data.value.length}');
      for (final event in newCovidEvents.data.value) {
        if (event.type == DocumentChangeType.added) {
          /// If id is already in repository is a duplicate -> skip!
          if (-1 !=
              eventsRepository.indexWhere(
                  (element) => event.doc.data()['id'] == element.id)) {
            continue;
          }
//          print('adding: ${event.doc.data()['id']}');
          try {
            eventsRepository
                .add(EventModel.fromDocumentSnapshot(event.doc, type: true));
          } catch (e) {
            print('error: $e');
          }
        } else if (event.type == DocumentChangeType.removed) {
          eventsRepository
              .removeWhere((item) => item.id == event.doc.data()['id']);
        }
      }
    }
  }

  ///*********** NEW VERSION OF OEMCP DOESNT INCLUDE SANITATION*************
//  if (newSanitationEvents.data != null) {
//    if (newSanitationEvents.data.value != null) {
//      for (final event in newSanitationEvents.data.value) {
//        if (event.type == DocumentChangeType.added) {
//          if (-1 !=
//              eventsRepository.indexWhere(
//                  (element) => event.doc.data()['id'] == element.id)) {
//            continue;
//          }
//          eventsRepository.add(
//              BuildingEventModel.fromDocumentSnapshot(event.doc, type: false));
//        } else if (event.type == DocumentChangeType.removed) {
//          eventsRepository
//              .removeWhere((item) => item.id == event.doc.data()['id']);
//        }
//      }
//    }
//  }

  /// Filter by Date
  final filter = ref.watch(filterDateProvider).state;
//  print('filter: $filter');
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

    List<EventModel> filterList = [];
    for (int i = 0; i < eventsRepository.length; i++) {
      if (eventsRepository[i].timestamp.isAfter(filterDateTime)) {
        filterList.add(eventsRepository[i]);
      }
    }
//    print('filterList.length: ${filterList.length}');
    return filterList;
  } else {
//    print('eventsRepository.length: ${eventsRepository.length}');
    return eventsRepository;
  }
});
