import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/service_firebase.dart';

class TodoTitle extends StatefulWidget {
  const TodoTitle({super.key});

  @override
  State<TodoTitle> createState() => _TodoTitleState();
}

class _TodoTitleState extends State<TodoTitle> {
  Future<void> addTodo(String task) async {
    // creons la variable qui va recuperer l'user connecte
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('todos').add({
        'task': task,
        'completed': false,
        'userId': user.uid,
      });
    }
  }

  final _globalKey = GlobalKey<FormState>();
  final TextEditingController tache = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: tache,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " le champ est obligatoire";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Tache',
                      labelStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        try {
                          await addTodo(tache.text);
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Ajouter une tache'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
