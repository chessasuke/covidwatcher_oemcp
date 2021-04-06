import 'package:covid_watcher/controllers/filterProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void StringCallback(String val);

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({this.callback});

  final StringCallback callback;

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 40, maxWidth: 250),
              child: TextField(
                textAlign: TextAlign.center,
                focusNode: _focusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _controller,
                onChanged: widget.callback,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      width: 3,
                    ),
                  ),
                  suffixIcon: const Icon(FontAwesomeIcons.searchLocation),
                  filled: true,
                  contentPadding: const EdgeInsets.only(top: 5),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  hintText: "Search Building",
                  fillColor: Colors.transparent.withOpacity(0.7),
                ),
              ),
            ),
//            Consumer(builder: (context, watch, child) {
//              final buildingList = watch(filterProvider(_controller.text));
//
//              return Container(
//                  color: const Color(0xD1117),
//                  constraints: const BoxConstraints(maxHeight: 150),
//                  child: ListView(
//                    itemExtent: 30,
//                    children: buildingList
//                        .map((e) => ListTile(
//                              title: Text(e.name),
//                            ))
//                        .toList(),
//                  ));
//            })
          ],
        ));
  }
}
