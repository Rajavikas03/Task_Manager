import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_/Pages/Home.dart';

class MarkAsCompeleted extends StatefulWidget {
  const MarkAsCompeleted({super.key});

  @override
  State<MarkAsCompeleted> createState() => _MarkAsCompeletedState();
}

class _MarkAsCompeletedState extends State<MarkAsCompeleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
                context, CupertinoPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: const Text("Mark as Compeleted"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Mark as compeleted')
            .snapshots(),
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
              return
                  //  GestureDetector(
                  //   onTap: () {
                  //     print("$documentId hii");
                  //     Navigator.pushReplacement(
                  //         context,
                  //         CupertinoPageRoute(
                  //             builder: (context) => TaskDetailPage(
                  //                   title: data['Title'],
                  //                   description: data['Description'],
                  //                   deadline: data['DeadLine'],
                  //                   documentId: documentId,
                  //                 )));
                  //   },
                  //   child:
                  Padding(
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
                                    fontSize: 25, fontWeight: FontWeight.w400),
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
                // ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
