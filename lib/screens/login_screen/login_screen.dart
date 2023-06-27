import 'package:appdiariooo/screens/register_screen/register_screen.dart';
import 'package:appdiariooo/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  AuthService service = AuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(0),
        decoration:
            BoxDecoration(border: Border.all(width: 8), color: Colors.grey),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.bookmark,
                    size: 64,
                    color: Colors.green,
                  ),
                  const Text(
                    "Simple Journal",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text("By Marlon Silva",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 17)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 2),
                  ),
                  const Text(
                    "Entre ou Registre-se",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("E-mail"),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(label: Text("Senha")),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Background color
                      ),
                      child: const Text(
                        "Continuar",
                        style: TextStyle(fontSize: 16),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (contextNew) =>
                                  RegisterScreen(taskContext: context),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                        ),
                        child: const Text(
                          "Registrar-se",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() {
    String email = emailController.text;
    String password = _password.text;

    service.login(email: email, password: password);
  }
}
