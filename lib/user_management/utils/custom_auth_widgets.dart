import 'package:flutter/material.dart';

class FormSectionTitle extends StatelessWidget {
  final String text;

  // ignore: sort_constructors_first
  const FormSectionTitle({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            left: 20.0,
            bottom: 8,
          ),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle2.color,
              fontSize: 18,
              // fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              // letterSpacing: 3,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleLogo extends StatelessWidget {
  const TitleLogo({
    @required this.title,
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: title == null
          ? CircularProgressIndicator()
          : Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1.color,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
    );
  }
}

/// Handle error text below reset password (field errorText on TextField Replicated)
class ReenterPassText extends StatelessWidget {
  ReenterPassText({this.text, this.colour});
  final String text;
  final bool colour;
  @override
  Widget build(BuildContext context) {
    return text == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 20),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(
                    color: colour == true ? Colors.green : Colors.red,
                    fontSize: 12),
              ),
            ),
          );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {@required this.btnValue,
      @required this.title,
      @required this.callBack,
      this.groupVal = -1});

  final int btnValue;
  final String title;
  final void Function(int) callBack;
  final int groupVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.green,
          value: btnValue,
          groupValue: groupVal,
          onChanged: callBack,
        ),
        Text(title)
      ],
    );
  }
}
