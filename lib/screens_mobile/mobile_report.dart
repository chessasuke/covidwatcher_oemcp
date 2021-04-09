import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animation.dart';
import '../auth/signin.dart';

class MobileReport extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final screenSize = MediaQuery.of(context).size;
//    final currentUser = watch(userProvider);

    return SafeArea(
        child: Stack(
      children: [
        Positioned(
          child: Container(
              constraints: const BoxConstraints(maxHeight: 350, maxWidth: 375),
              child: const AnimationExample()),
        ),
        const Positioned.fill(
          top: 10,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text('Self Report',
                style: TextStyle(color: Colors.red, fontSize: 24)),
          ),
        ),
        Positioned.fill(
          top: 400,
          child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SignIn();
                    });
              },
              child: Text(
                'Sign in',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .copyWith(color: Colors.blue),
              )),
        ),
        const Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0, top: 8),
                  child: Text('Please sign in to send a Covid Self-Report'),
                ))),
      ],
    ));
  }
}
