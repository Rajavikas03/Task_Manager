import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_/FirebaseDatabase/Auth.dart';
import 'package:task_manager_/Pages/Add_page.dart';
import 'package:task_manager_/Pages/MarkAsCompeleted.dart';
import 'package:task_manager_/Pages/Task_Detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signout() async {
    await Auth().signOut();
  }

  Widget _userid() {
    return Text(
      user?.email ?? "User Email",
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(5),
          children: <Widget>[
            const Gap(60),
            CircleAvatar(
              radius: 80,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset("assets/icons/user.png"),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                _userid(),
              ],
            ),
            const Gap(10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const MarkAsCompeleted()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  tileColor: Colors.blueGrey,
                  title: Center(
                    child: Text(
                      "Mark as Compeleted",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: signout, child: const Text("Signout")),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Task Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          const Gap(10),
          ElevatedButton(onPressed: signout, child: const Icon(Icons.logout)),
          const Gap(10)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('New Task').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String documentId = document.id;
              return GestureDetector(
                onTap: () {
                  print("$documentId hii");
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => TaskDetailPage(
                                title: data['Title'],
                                description: data['Description'],
                                deadline: data['DeadLine'],
                                documentId: documentId,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                      height: 200,
                      child: Card(
                        color: Colors.blueGrey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 12, left: 12, bottom: 5, right: 12),
                                  child: Text(
                                    "Title:",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  data['Title'],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 5, left: 12, right: 12, bottom: 5),
                                  child: Text(
                                    "Description: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    data['Description'],
                                    maxLines: 4,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 12,
                                  ),
                                  child: Text(
                                    "DeadLine: ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  data['DeadLine'],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => const AddPage()));
        },
        child: const Tooltip(
            textStyle: TextStyle(color: Colors.black),
            message: "Add Task",
            child: Icon(Icons.add)),
      ),
    );
  }
}
