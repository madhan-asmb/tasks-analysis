import 'package:flutter/material.dart';
import 'package:task_analysis/view/widgets/auth_button.dart';
import 'package:task_analysis/view/widgets/dialogs_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Size size = MediaQuery.of(context).size;
    TextStyle welcome = TextStyle(
        fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700);
    TextStyle subTitle = TextStyle(fontSize: 16, color: Colors.white);
    TextStyle titleText = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w900,
      letterSpacing: 3,
      color: primaryColor,
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 100,
                child: Image.asset(
                  'assets/taskAnalysisLogo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Task Analysis",
                style: titleText,
              ),
              Spacer(),
              Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 80, left: 20, right: 20),
                width: size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: welcome,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Notebooks are the best place to manage your notes and capture your Ideas",
                      style: subTitle,
                    ),
                    SizedBox(height: 20),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      buttonPadding: EdgeInsets.all(8),
                      children: [
                        AuthButtons(
                          text: "Login",
                          color: Colors.orange,
                          onPressed: () {
                            showRegisterForm(context, isLogin: true);
                          },
                        ),
                        AuthButtons(
                          text: "Register",
                          color: Colors.red,
                          onPressed: () {
                            showRegisterForm(context, isLogin: false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
