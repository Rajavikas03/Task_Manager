import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_/FirebaseDatabase/CRED.dart/AddData.dart';
import 'package:task_manager_/Pages/Edit_Task.dart';
import 'package:task_manager_/Pages/Home.dart';

class TaskDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String deadline;
  final documentId;

  const TaskDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.documentId,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  Future<void> _deleteTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('New Task')
          .doc(widget.documentId)
          .delete();
      print('Task deleted successfully');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Task Details",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => EditTaskPage(
                              documentId: widget.documentId,
                              description: widget.description,
                              deadline: widget.deadline,
                              title: widget.title,
                            )));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                await _deleteTask();
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => HomePage()));
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(10),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Text(
              "DeadLine: ${widget.deadline}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 10),
        child: ElevatedButton(
            onPressed: () async {
              await _deleteTask();
              await AddData().add_Data_(
                  title: widget.title,
                  description: widget.description,
                  deadline: widget.deadline);
              print("Data Add to Mark as compeleted");
            },
            child: const Text("Mark as Completed")),
      ),
    );
  }
}
