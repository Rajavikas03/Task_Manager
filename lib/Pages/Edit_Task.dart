import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_/Pages/Home.dart';
import 'package:task_manager_/Utlies/Custom_widgets/DescriptionField.dart';
import 'package:task_manager_/Utlies/Custom_widgets/TextField.dart';

class EditTaskPage extends StatefulWidget {
  final String documentId;
  final String title;
  final String description;
  final String deadline;
  const EditTaskPage(
      {super.key,
      required this.documentId,
      required this.deadline,
      required this.description,
      required this.title});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  String? errorMessage = '';

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controlleerDateTime = TextEditingController();

  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert !!!'),
          content: const Text('Please fill all required fields'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> seletedDate() async {
    DateTime? _selected = await showDatePicker(
        context: context,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050),
        initialDate: DateTime.now());
    if (_selected != null) {
      setState(() {
        _controlleerDateTime.text = DateFormat('dd/MM/yyyy').format(_selected);
      });
    }
  }

  Widget dead_Line(
    TextEditingController controller,
    String labeltext,
    String hinttext,
  ) {
    return SizedBox(
      width: 150,
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              seletedDate();
            },
            icon: const Icon(Icons.date_range),
          ),
          fillColor: Colors.lightBlueAccent,
          labelText: labeltext,
          hintText: hinttext,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
            ),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Future<void> _updateTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('New Task')
          .doc(widget.documentId)
          .update({
        'Title': _controllerTitle.text,
        'Description': _controllerDescription.text,
        'DeadLine': _controlleerDateTime.text,
      });
      print('Task updated successfully');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _controlleerDateTime.text = widget.deadline;
    _controllerDescription.text = widget.description;
    _controllerTitle.text = widget.title;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Edit Task",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            CustomTextField(
              labeltext: 'Title',
              hinttext: 'Enter Task Title...',
              controller: _controllerTitle,
            ),
            const Gap(30),
            DescriptionField(
                labeltext: "Description",
                hinttext: "Enter Detail Description",
                controller: _controllerDescription),
            const Gap(30),
            dead_Line(_controlleerDateTime, "Deadline", "Enter a Date"),
            const Gap(30),
            ElevatedButton(
                onPressed: () async {
                  if (_controllerTitle.text.isNotEmpty &&
                      _controllerDescription.text.isNotEmpty) {
                    await _updateTask();
                    if (!mounted) return;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    _showMyDialog(context);
                  }
                },
                child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
