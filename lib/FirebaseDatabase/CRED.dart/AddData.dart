import 'package:cloud_firestore/cloud_firestore.dart';

class AddData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> add_Data({
    required String title,
    required String description,
    required String deadline,
    // required  date,
  }) async {
    await _firestore.collection('New Task').add(
        {'Title': title, 'Description': description, 'DeadLine': deadline});
  }

  Future<void> add_Data_({
    required String title,
    required String description,
    required String deadline,
    bool markAsCompeleted = true,
    // required  date,
  }) async {
    await _firestore.collection('Mark as compeleted').add({
      'Title': title,
      'Description': description,
      'DeadLine': deadline,
      'Mark as compeleted': markAsCompeleted
    });
  }
}
