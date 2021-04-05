import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.Background,
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.10,
              ),
              Center(
                child: Image.asset(
                  "assets/icons/logo_blue.png",
                  width: MediaQuery.of(context).size.width * 0.20,
                  cacheWidth:
                      (MediaQuery.of(context).size.width * 0.20).toInt(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Selamat datang di Tototok",
                textAlign: TextAlign.center,
                style: CustomTheme.Title,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sign in untuk melanjutkan",
                style: TextStyle(color: CustomTheme.Grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Email Anda",
                    prefixIcon: Icon(
                      Icons.mail,
                      color: CustomTheme.Grey,
                    ),
                    border: OutlineInputBorder(),
                    isDense: true),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: CustomTheme.Grey,
                    ),
                    border: OutlineInputBorder(),
                    isDense: true),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(CustomTheme.Blue)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Divider(
                    height: 50,
                    endIndent: 10,
                    color: CustomTheme.Grey,
                  )),
                  Text("OR"),
                  Expanded(
                      child: Divider(
                    indent: 10,
                    height: 50,
                    color: CustomTheme.Grey,
                  ))
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Login with Google"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(CustomTheme.Background),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(
                      BorderSide(color: CustomTheme.Grey)),
                  foregroundColor: MaterialStateProperty.all(CustomTheme.Grey),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Login with Facebook"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(CustomTheme.Background),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(
                      BorderSide(color: CustomTheme.Grey)),
                  foregroundColor: MaterialStateProperty.all(CustomTheme.Grey),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Lupa Password?",
                style: TextStyle(
                    color: CustomTheme.Blue, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "Tidak punya akun? ",
                      style: TextStyle(color: CustomTheme.Grey),
                      children: [
                    TextSpan(
                        text: "Registrasi",
                        style: TextStyle(
                            color: CustomTheme.Blue,
                            fontWeight: FontWeight.bold))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
