import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/firebase_firestore_services.dart';
import 'user_model.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier>((ref) {
  final userStreamData = ref.watch(authStateProvider);

  /// Check if firebase
  if (userStreamData.data != null) {
    if (userStreamData.data.value != null) {
      if (userStreamData.data.value.uid != null) {
        print('User Signed In uid: ${userStreamData.data.value.uid}');
        ref.maintainState = true;
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
        print('info loaded');
        state =
            UserLoaded(user: UserModel.fromDocumentReference(doc: userInfo));
        print('user loaded');
      } catch (e) {
        /// IF UID DOESNT EXIST IT WILL RETURN ERROR
        /// be aware that deleting the account must be synchronize,
        /// the firebase auth with the user info in firestore
        /// when deleting a firebase user we must delete the corresponding
        print(e);
        state = const UserError();
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

  UserModel get getUser => user;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserLoaded && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UserError extends UserState {
//  final String message;
//  const UserError(this.message);
  const UserError();

//  @override
//  bool operator ==(Object o) {
//    if (identical(this, o)) return true;
//
//    return o is UserError && o.message == message;
//  }
//
//  @override
//  int get hashCode => message.hashCode;
}
