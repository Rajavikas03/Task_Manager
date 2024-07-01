import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_/FirebaseDatabase/CRED.dart/AddData.dart';
import 'package:task_manager_/Pages/Home.dart';
import 'package:task_manager_/Utlies/Custom_widgets/DescriptionField.dart';
import 'package:task_manager_/Utlies/Custom_widgets/TextField.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? errorMessage = '';

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controlleerDateTime = TextEditingController();

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

  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert !!!'),
          content: const Text('Please fill all required fields '),
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

  Future<void> _addData() async {
    try {
      if (_controllerTitle.text.isNotEmpty &&
          _controllerDescription.text.isNotEmpty) {
        await AddData().add_Data(
            title: _controllerTitle.text,
            description: _controllerDescription.text,
            deadline: _controlleerDateTime.text);
        // print("data added sucessfully");
      }
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Add Task",
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
            dead_Line(_controlleerDateTime, "Dead Line", "Emter a Date"),
            const Gap(30),
            ElevatedButton(
                onPressed: () async {
                  if (_controllerTitle.text.isNotEmpty &&
                      _controllerDescription.text.isNotEmpty) {
                    await _addData();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    _showMyDialog(context);
                  }
                },
                child: const Text("Add Task")),
          ],
        ),
      ),
    );
  }
}
