import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/services/service_firebase.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loading = false;
  bool _forlogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _forlogin ? 'Connexion' : 'Inscription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email obligatoire";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                      return "Email invalide";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password obligatoire";
                    return null;
                  },
                ),
              ),
              if (!_forlogin)
                Padding(
                  padding: EdgeInsetsGeometry.all(12),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password Confirmation',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "les deux mot de passs sont identiques";
                      } else if (value == null || value.isEmpty) {
                        return "le champ est obligatoire";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          try {
                            if (_forlogin) {
                              await Auth().login(
                                emailController.text,
                                passwordController.text,
                              );
                            } else {
                              await Auth().createUser(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                            );
                            // Redirection automatique gérée par RedirectionPage
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          } finally {
                            setState(() => loading = false);
                          }
                        }
                      },
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        _forlogin ? 'Se connecter' : 'S\'inscrire',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _forlogin = !_forlogin;
                      passwordController.text = "";
                      confirmPasswordController.text = "";
                      emailController.text = "";
                    });
                  },
                  child: Text(
                    _forlogin
                        ? "Je n'ai pas de compte,s'inscrire "
                        : "J\'ai deja un compte",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
