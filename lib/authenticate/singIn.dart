import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:photo_album/home/dashboard.dart';
import 'package:photo_album/shared/constants.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SignIn extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Pin Sign in
              Container(
                child: PinPut(
                  fieldsCount: 4,
                  onChanged: (String pin) {
                    if (pin == '1234') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()));
                    }
                  },
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  fieldsAlignment: MainAxisAlignment.spaceEvenly,
                  eachFieldWidth: 45.0,
                  eachFieldHeight: 55.0,
                  submittedFieldDecoration: pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.deepPurpleAccent.withOpacity(.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _pinPutFocusNode.requestFocus(),
                    child: const Text('Focus'),
                  ),
                  RaisedButton(
                    onPressed: () => _pinPutFocusNode.unfocus(),
                    child: const Text('Unfocus'),
                  ),
                  RaisedButton(
                    onPressed: () => _pinPutController.text = '',
                    child: const Text('Clear All'),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              // Or text
              Text(
                'Or',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              // Touch Login Button
              RaisedButton(
                child: Text('Touch to Sign In'),
                onPressed: () async {
                  bool checkBio = await localAuth.canCheckBiometrics;
                  if (checkBio) {
                    bool authenticated =
                        await localAuth.authenticateWithBiometrics(
                            localizedReason: 'Authenticate to go to Dashboard');

                    if (authenticated) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()));
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
