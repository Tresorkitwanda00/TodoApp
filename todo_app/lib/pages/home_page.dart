import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/login.dart';
import 'package:todo_app/pages/todo_title.dart';
import 'package:todo_app/services/service_firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> getTodo() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('todos')
        .where('userId', isEqualTo: user!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getTodoCompleted() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('todos')
        .where('userId', isEqualTo: user!.uid) // Filtrer par utilisateur
        .where('completed', isEqualTo: true)
        .snapshots();
  }

  Future<void> updateTodo(String id, bool completed) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).update({
      'completed': completed,
    });
  }

  Future<void> deleteTodo(String id) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }

  final email = Auth().currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO APP'),
          actions: [Text(email.toString())],
          leading: IconButton(
            onPressed: () async {
              Auth().logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: Icon(Icons.login_outlined),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Taches'),
                Tab(text: 'Achevées'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: getTodo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("Aucun todo"));
                      }

                      final todos = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo =
                              todos[index].data() as Map<String, dynamic>;
                          final id = todos[index].id;
                          return ListTile(
                            title: Text(todo['task']),
                            trailing: Checkbox(
                              value: todo['completed'],
                              onChanged: (value) async {
                                await updateTodo(id, !todo['completed']);
                              },
                            ),
                            onLongPress: () => deleteTodo(id),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: getTodoCompleted(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("Aucun todo"));
                      }

                      final todos = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo =
                              todos[index].data() as Map<String, dynamic>;
                          final id = todos[index].id;
                          return ListTile(title: Text(todo['task']));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoTitle()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
