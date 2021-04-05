import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
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
                "Silahkan Memulai",
                textAlign: TextAlign.center,
                style: CustomTheme.Title,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Buat akun baru",
                style: TextStyle(color: CustomTheme.Grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(Icons.person),
                    labelText: "Nama Lengkap"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Email Anda"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Tulis Ulang Password"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(CustomTheme.Blue)),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: "Punya akun? ",
                      style: TextStyle(color: CustomTheme.Grey),
                      children: [
                    TextSpan(
                        text: "Sign In",
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
