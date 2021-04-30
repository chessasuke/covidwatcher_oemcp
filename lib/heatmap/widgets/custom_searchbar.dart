import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({this.callback});
  final StringCallback callback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: callback,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 5),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Search Building",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
