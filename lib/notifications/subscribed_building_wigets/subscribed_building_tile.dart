import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Widget tiles that appear in the manage notification section with
/// the Buildings for which we are subscribed to receive notifications
/// has a function to quickly remove the corresponding building

typedef RemoveItem = void Function();

class SubscribedBuildingTile extends StatelessWidget {
  const SubscribedBuildingTile({this.name, this.callback});
  final String name;
  final RemoveItem callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(name),
      trailing: IconButton(
        icon: const Icon(FontAwesomeIcons.solidTrashAlt),
        onPressed: callback,
      ),
    );
  }
}
