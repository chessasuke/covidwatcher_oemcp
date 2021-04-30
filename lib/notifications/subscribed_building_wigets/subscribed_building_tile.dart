import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).disabledColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            SizedBox(
              width: screenSize.width * 0.7,
              child: Text(name, maxLines: 2, overflow: TextOverflow.clip),
            ),
            Flexible(
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.solidTrashAlt),
                onPressed: callback,
              ),
            ),
          ],
        ),
      ),
    );
//      ListTile(
//      leading: Text(name, overflow: TextOverflow.clip, maxLines: 1),
//      trailing: IconButton(
//        icon: const Icon(FontAwesomeIcons.solidTrashAlt),
//        onPressed: callback,
//      ),
//    );
  }
}
