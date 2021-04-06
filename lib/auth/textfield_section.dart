import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logic_functions.dart';

/// TextField Section to input user info
class TextFieldSection extends StatefulWidget {
  final Function callBackTextController;
  final String inputType;
  final String hintText;
  final String initialValue;
  final String textInputAction;
  final String pass2;

  TextFieldSection({
    @required this.callBackTextController,
    @required this.inputType,
    this.initialValue,
    this.hintText,
    this.textInputAction = 'next',
    this.pass2,
  });

  @override
  _TextFieldSectionState createState() => _TextFieldSectionState();
}

class _TextFieldSectionState extends State<TextFieldSection> {
  TextEditingController textController = TextEditingController();
  bool _isEditing = false;
  FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    if (widget.initialValue != null) {
      textController.text = widget.initialValue;
    }
    super.initState();
  }

  TextInputType getKeyboardType() {
    if (widget.inputType == 'email')
      return TextInputType.emailAddress;
    else
      return TextInputType.text;
  }

  String validateInput(String input) {
    if (widget.inputType == 'email')
      return AuthenticationService.validateEmail(input);
    else if (widget.inputType == 'name')
      return null;
    else if (widget.inputType == 'password')
      return AuthenticationService.validatePassword(input);
    else if (widget.inputType == 'password2')
      return null;
    else
      return 'Error at input validation';
  }

  List<TextInputFormatter> getInputFormatters() {
    if (widget.inputType == 'phone')
      return [FilteringTextInputFormatter.digitsOnly];
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: getInputFormatters(),
      focusNode: textFocusNode,
      keyboardType: getKeyboardType(),
      textInputAction: widget.textInputAction == 'done'
          ? TextInputAction.done
          : TextInputAction.next,
      controller: textController,
      obscureText:
          widget.inputType == 'password' || widget.inputType == 'password2'
              ? true
              : false,
      autofocus: false,
      onChanged: (value) {
        widget.callBackTextController(value);
        setState(() {
          _isEditing = true;
        });
      },
      onSubmitted: (value) {
        textFocusNode..nextFocus();
        setState(() {
          _isEditing = false;
        });
      },
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
//        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.blueGrey[800],
            width: 3,
          ),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.blueGrey[300],
        ),
        hintText: widget.hintText,
        fillColor: Colors.white,
//********************************************************************
// Real Time username check not supported right now
        errorText: _isEditing ? validateInput(textController.text) : null,
//********************************************************************
        errorStyle: TextStyle(
          fontSize: 12,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
