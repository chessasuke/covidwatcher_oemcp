import 'dart:typed_data';

import 'package:covid_watcher/service/firebase_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logic_functions.dart';
import 'custom_auth_widgets.dart';
import 'signup_followup.dart';
import 'textfield_section.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key key,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isRegistering = false;

  String loginStatus;
  Color loginStringColor = Colors.green;

  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  String name;
  String lastname;
  String email = '@utdallas.edu';
  String password1;
  String password2;
  String username;

  String imgURL;
  Uint8List dataImg;

  @override
  void initState() {
    super.initState();
    textControllerEmail = TextEditingController();
    textControllerEmail.text = '';
    textFocusNodeEmail = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              /// Name
              const SizedBox(height: 20),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Flexible(child: FormSectionTitle(text: 'Name')),
                  const Text(' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFieldSection(
                  callBackTextController: (String value) {
                    name = value;
                  },
                  inputType: 'name',
                  hintText: 'Name',
                ),
              ),

              /// Last Name
              ///
              const SizedBox(height: 20),
              Row(
                children: const [
                  Flexible(child: FormSectionTitle(text: 'Last Name')),
                  Text(' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFieldSection(
                  callBackTextController: (String value) {
                    lastname = value;
                  },
                  inputType: 'name',
                  hintText: 'Last Name',
                ),
              ),

              const SizedBox(height: 20),

              // EMAIL
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Flexible(child: FormSectionTitle(text: 'Email')),
                  const Text(' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: textControllerEmail,
                        onChanged: (value) {
                          setState(() {
                            _isEditingEmail = true;
                            textControllerEmail.text = value;
                            // ignore: cascade_invocations
                            textControllerEmail.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: textControllerEmail.text.length));
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 3,
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.blueGrey[300],
                          ),
                          hintText: "Email",
                          fillColor: Colors.white,
                          errorText: _isEditingEmail
                              ? AuthenticationService.validateEmail(
                                          textControllerEmail.text) ==
                                      'Email bad format'
                                  ? 'Bad format'
                                  : null
                              : null,
                          errorBorder: InputBorder.none,
                          errorStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).dividerColor)),
                      width: 110,
                      constraints:
                          const BoxConstraints(maxWidth: 200, maxHeight: 59),
                      child: const Center(child: Text(' @utdallas.edu')),
                    )
                  ],
                ),
              ),

              // PASSWORD
              const SizedBox(height: 20),
              Row(
                children: const [
                  Flexible(child: FormSectionTitle(text: 'Password')),
                  Text(' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFieldSection(
                  callBackTextController: (String value) {
                    setState(() {
                      password1 = value;
                    });
                  },
                  inputType: 'password',
                  hintText: 'Password',
                ),
              ),

              // PASSWORD 2
              const SizedBox(height: 20),
              Row(
                children: const [
                  Flexible(child: FormSectionTitle(text: 'Re-enter Password')),
                  Text(' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFieldSection(
                  callBackTextController: (String value) {
                    setState(() {
                      password2 = value;
                    });
                  },
                  inputType: 'password2',
                  hintText: 'Re-enter password',
                ),
              ),
              if (AuthenticationService
                      .validatePassword2(password1, password2) ==
                  'ok')
                ReenterPassText(text: 'Password match', colour: true)
              else
                ReenterPassText(
                    text: AuthenticationService.validatePassword2(
                        password1, password2),
                    colour: false),

              // SIGN UP BUTTON
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                          width: double.maxFinite,
                          child: TextButton(
                            onPressed: () async {
                              if (AuthenticationService.validateEmail(
                                          textControllerEmail.text) ==
                                      null &&
                                  AuthenticationService.validatePassword(
                                          password1) ==
                                      null &&
                                  AuthenticationService.validatePassword2(
                                          password1, password2) ==
                                      'ok') {
                                setState(() {
                                  _isRegistering = true;
                                });

                                String statusCode = await context
                                    .read(authServiceProvider)
                                    .signUp(
                                        name,
                                        lastname,
                                        textControllerEmail.text + email,
                                        password1);

                                print('statusCode: $statusCode');

                                setState(() {
                                  if (statusCode == 'ok') {
                                    loginStatus =
                                        'Verify your email with the link we sent you';
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignUpFollowUp();
                                    }));
                                  } else {
                                    if (statusCode == null) {
                                      loginStatus =
                                          'Error registering, please try again';
                                    } else
                                      loginStatus = statusCode;
                                  }
                                  loginStringColor = loginStatus ==
                                          'Verify your email with the link we sent you'
                                      ? Colors.green
                                      : Colors.red;
                                });
                              } else {
                                setState(() {
                                  loginStatus =
                                      'Please enter username, email & password';
                                  loginStringColor = Colors.red;
                                });
                              }
                              setState(() {
                                _isRegistering = false;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: _isRegistering
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              if (loginStatus != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Text(
                      loginStatus,
                      style: TextStyle(
                        color: loginStringColor,
                        fontSize: 14,
                        // letterSpacing: 3,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 1,
                  width: double.maxFinite,
                  color: Colors.blueGrey[200],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'By proceeding, you agree to our ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                            text: 'Terms of Use',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('go to term of use');
                              }),
                        const TextSpan(text: ' and confirm you have read our '),
                        TextSpan(
                            text: 'Privacy Policy.',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('go to privacy policy');
                              }),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
