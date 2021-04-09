import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/firebase_services.dart';
import 'user_model.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier>((ref) {
  final userStreamData = ref.watch(authStateProvider);

  /// Check if firebase
  if (userStreamData.data != null) {
    if (userStreamData.data.value != null) {
      if (userStreamData.data.value.uid != null) {
        return UserNotifier(uid: userStreamData.data.value.uid);
      }
    }
  }

  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  // ignore: sort_constructors_first
  UserNotifier({String uid}) : super(const UserInitial()) {
    getUserInfo(uid);
  }

  Future<void> getUserInfo(String uid) async {
    if (uid != null) {
      try {
        state = const UserLoading();
        final userInfo = await UserClient.fetchUserInfo(uid);
        state =
            UserLoaded(user: UserModel.fromDocumentReference(doc: userInfo));
      } catch (e) {
        state = const UserError('Error fetching user info');
      }
    }

    /// TODO check if this is an improvement
//    else {
//      state = const UserInitial();
//    }
  }
}

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  UserModel user;

  UserLoaded({this.user});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserLoaded && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
