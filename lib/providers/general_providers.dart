import 'package:flutter_riverpod/flutter_riverpod.dart';

/// THIS FILE CONTAINS GENERAL PROVIDERS

final loadingProvider = StateProvider<bool>((ref) => false);

final showNotificationRequest = StateProvider<bool>((ref) => true);
