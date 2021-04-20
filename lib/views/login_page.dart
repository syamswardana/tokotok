import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:tokotok/views/navigation.dart';
import 'package:tokotok/views/registration_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: MediaQuery.of(context).size.width * 0.15,
                  cacheWidth:
                      (MediaQuery.of(context).size.width * 0.15).toInt(),
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
                controller: emailController,
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
                controller: passwordController,
                obscureText: true,
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
                onPressed: () async {
                  await AuthServices.signInEmail(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                },
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
              OutlinedButton.icon(
                icon: SvgPicture.asset(
                  "assets/icons/gmail.svg",
                  height: 20,
                ),
                onPressed: () {
                  Future<UserCredential> user = AuthServices.signInWithGoogle();
                  user.then((user) {
                    if (user != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Navigation();
                      }));
                    }
                  });
                },
                label: Text("Login with Google"),
                style: ButtonStyle(
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
              OutlinedButton.icon(
                icon: SvgPicture.asset(
                  "assets/icons/facebook.svg",
                  height: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Fitur tidak tersedia")));
                },
                label: Text("Login with Facebook"),
                style: ButtonStyle(
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
              TextButton(
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Fitur tidak tersedia")));
                  },
                  child: Text(
                    "Lupa Password?",
                    style: TextStyle(
                        color: CustomTheme.Blue, fontWeight: FontWeight.bold),
                  )),
              RichText(
                  text: TextSpan(
                      text: "Tidak punya akun? ",
                      style: TextStyle(color: CustomTheme.Grey),
                      children: [
                    TextSpan(
                        text: "Registrasi",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return RegistrationForm();
                            }));
                          },
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
