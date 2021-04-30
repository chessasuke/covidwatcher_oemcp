import 'package:covid_watcher/app_themes/adabtableFontSize.dart';
import 'package:covid_watcher/fcm/fcm_config.dart';
import 'package:covid_watcher/user_management/logic/auth_logic.dart';
import 'package:covid_watcher/user_management/utils/strings.dart';
import 'package:covid_watcher/user_management/widgets/reset_password.dart';
import 'package:covid_watcher/user_management/widgets/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:covid_watcher/services_controller/firebase_auth_services.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final String email = '@utdallas.edu';
  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  TextEditingController textControllerPassword;
  FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;
  bool showPassword = false;

  String loginStatus;
  Color loginStringColor = Colors.green;

  ScrollController _scrollController;

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerEmail.text = null;
    textFocusNodeEmail = FocusNode();

    textControllerPassword = TextEditingController();
    textControllerPassword.text = null;
    textFocusNodePassword = FocusNode();

    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext thisContext) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// EMAIL
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: TextField(
                        focusNode: textFocusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: textControllerEmail,
                        onChanged: (String value) {
                          setState(() {
                            _isEditingEmail = true;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20)),
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
                              ? AuthenticationService.isEmailError(
                                      textControllerEmail.text)
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor)),
                    width: 110,
                    constraints:
                        const BoxConstraints(maxWidth: 200, maxHeight: 51),
                    child: const Center(child: Text(' @utdallas.edu')),
                  )
                ],
              ),

              // PASSWORD
              const SizedBox(height: 20),
              TextField(
                focusNode: textFocusNodePassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: textControllerPassword,
                obscureText: !showPassword,
                onChanged: (value) {
                  setState(() {
                    _isEditingPassword = true;
                  });
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(20)),
                    borderSide: BorderSide(
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: "Password",
                  fillColor: Colors.white,
                  errorText: _isEditingPassword
                      ? AuthenticationService.validatePassword(
                          textControllerPassword.text)
                      : null,
                  errorStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text(Strings.showPass),
                value: showPassword,
                onChanged: (bool newValue) {
                  setState(() {
                    showPassword = newValue;
                  });
                },
              ),
              // BUTTONS
              Container(
                constraints: const BoxConstraints(maxWidth: 550),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /// SIGN IN BUTTON
                        Flexible(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 200),
                            width: double.maxFinite,
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  textFocusNodeEmail.unfocus();
                                  textFocusNodePassword.unfocus();
                                });

                                String statusCode;

                                if (AuthenticationService.validateEmail(
                                            textControllerEmail.text) ==
                                        null &&
                                    AuthenticationService.validatePassword(
                                            textControllerPassword.text) ==
                                        null) {
                                  /// SIGN IN PROCESS START
                                  statusCode = await context
                                      .read(authServiceProvider)
                                      .signIn(textControllerEmail.text + email,
                                          textControllerPassword.text);

                                  if (statusCode == 'ok') {
                                    setState(() {
                                      loginStatus =
                                          'You have successfully logged in';
                                      loginStringColor = Colors.green;
                                    });
                                    Navigator.pop(thisContext, 'update!');
                                  } else {
                                    /// Scroll to the end to make sure error is displayed to user
                                    if (_scrollController.hasClients) {
                                      await _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeInOut);
                                    }

                                    print('statusCode: $statusCode');
                                    loginStringColor = Colors.red;
                                    setState(() {
                                      if (statusCode != null)
                                        loginStatus = statusCode;
                                      else {
                                        loginStatus =
                                            'Error while trying to log in.';
                                      }
                                    });
                                  }
                                } else {
                                  setState(() {
                                    loginStatus =
                                        'Please enter email & password';
                                    loginStringColor = Colors.red;
                                  });
                                }
                                setState(() {
                                  _isEditingEmail = false;
                                  _isEditingPassword = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(Strings.login),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// Reset Pass/Create Account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Reset Pass
                            Flexible(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  if (AuthenticationService.validateEmail(
                                          textControllerEmail.text) ==
                                      null) {
                                    String statusCode = await context
                                        .read(authServiceProvider)
                                        .resetPassword(
                                            textControllerEmail.text);
                                    if (statusCode == 'ok') {
                                      await showDialog(
                                          context: thisContext,
                                          builder: (BuildContext context) {
                                            return ResetPassword();
                                          });
                                    } else {
                                      await showDialog(
                                          context: thisContext,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content: Text(statusCode),
                                            );
                                          });
                                    }
                                  } else {
                                    await showDialog(
                                        context: thisContext,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            title: Text("Error"),
                                            content: Text(Strings.emailError),
                                          );
                                        });
                                  }
                                },
                                child: Text(Strings.resetPass,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: FlexFontSize.getFontSize(
                                                    context)
                                                .bodyText2
                                                .fontSize)),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 1,
                                height: 20,
                                color: Colors.blueGrey[200],
                              ),
                            ),

                            /// Create Acc
                            Flexible(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: thisContext,
                                      builder: (context) {
                                        return const SignUp();
                                      });
                                },
                                child: Text(Strings.createAcc,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: FlexFontSize.getFontSize(
                                                    context)
                                                .bodyText2
                                                .fontSize)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              if (loginStatus != null)
                Center(
                  child: Text(
                    loginStatus,
                    style:
                        TextStyle(color: loginStringColor // letterSpacing: 3,
                            ),
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}
