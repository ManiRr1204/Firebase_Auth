import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'loginwidget.dart';
import 'signUpWidget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogIn = true;
  @override
  Widget build(BuildContext context) {
    return isLogIn
        ? LoginWidget(onClickedSignUp: toggle)
        : SignUpWidget(onClickedSignIn: toggle);
  }

  void toggle() => setState(() {
        isLogIn = !isLogIn;
      });
}
