import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/tache.dart';

class TodoTitle extends StatefulWidget {
  const TodoTitle({super.key});

  @override
  State<TodoTitle> createState() => _TodoTitleState();
}

class _TodoTitleState extends State<TodoTitle> {
  final _globalKey = GlobalKey<_TodoTitleState>();
  final TextEditingController tache = TextEditingController();
  List<Tache> taches = [];
  Future<void> fetchdata() async {
    final response = await http.get(Uri.parse(''));
    if (response.statusCode == 201) {
      List jsonData = json.decode(response.body);
      setState(() {
        taches = jsonData
            .map((toElement) => Tache.fromJson(toElement))
            .toList();
      });
    } else {
      throw Exception('erreur de chargement');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
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
                  child: TextField(
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
                    onPressed: () {},
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
