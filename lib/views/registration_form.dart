import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/views/custom_theme.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController rePasswordController = TextEditingController(text: "");
  ValueNotifier<bool> rePasswordError = ValueNotifier(false);
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
                  width: MediaQuery.of(context).size.width * 0.15,
                  cacheWidth:
                      (MediaQuery.of(context).size.width * 0.15).toInt(),
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
                controller: nameController,
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
                controller: emailController,
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
                controller: passwordController,
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
              ValueListenableBuilder(
                  valueListenable: rePasswordError,
                  builder: (context, error, _) {
                    return TextFormField(
                      controller: rePasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Tulis Ulang Password"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        return (error) ? "Password tidak sama" : null;
                      },
                      onChanged: (text) {
                        rePasswordError.value = false;
                      },
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  String msg = "Error";
                  if (nameController.text == "" ||
                      emailController.text == "" ||
                      passwordController.text == "" ||
                      rePasswordController.text == "") {
                    msg = "Mohon isi semua data";
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(msg)));
                  } else if (passwordController.text !=
                      rePasswordController.text) {
                    rePasswordError.value = true;
                  } else {
                    await AuthServices.signUpEmail(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                    Navigator.pop(context);
                  }
                },
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
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
