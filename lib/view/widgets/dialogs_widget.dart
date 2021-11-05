import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:task_analysis/network_module/api_response.dart';
import 'package:task_analysis/provider/auth_provider.dart';
import 'package:task_analysis/view/screens/home_page.dart';

import 'auth_button.dart';

void showRegisterForm(BuildContext context, {required bool isLogin}) {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        content: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              AuthButtons(
                text: isLogin ? 'Login' : 'Register',
                color: Colors.red,
                onPressed: () async {
                  if (isLogin) {
                    Navigator.of(context).pop();
                    await authProvider.loginUser();
                    await Provider.of<AuthProvider>(context, listen: false)
                        .getRegisteredUsers();
                    if (authProvider.user.status == Status.COMPLETED) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    } else if (authProvider.user.status == Status.LOADING) {
                      showMessageDialog(
                          context, authProvider.user.message ?? 'Loading');
                    } else if (authProvider.user.status == Status.ERROR) {
                      print(authProvider.user.message);
                      showMessageDialog(context,
                          authProvider.user.message ?? 'Something went wrong');
                    }
                  } else {
                    Provider.of<AuthProvider>(context, listen: false)
                        .registerUser();

                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

void showLoadingIndicator(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 30,
          child: SpinKitCubeGrid(
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
        ),
      );
    },
  );
}

void showMessageDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        content: Container(
          child: Text(message),
        ),
      );
    },
  );
}
