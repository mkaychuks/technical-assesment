import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern/screens/screens.dart';
import 'package:intern/widgets/widgets.dart';

class MedicineDbMethods {
  final CollectionReference _medicine =
      FirebaseFirestore.instance.collection('medicine');

  Future addToDb({
    required BuildContext context,
    required String title,
  }) async {
    try {
      var data = {"title": title};
      await _medicine.add(data);
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const MedicineHomePage(),
          ),
        );
      }
    } on SocketException {
      showSnackBar(
        color: Colors.red,
        text: "Internet connection not stabe",
        context: context,
      );
    } catch (e) {
      showSnackBar(
        color: Colors.red,
        text: "Something went wrong",
        context: context,
      );
    }
  }

  Stream<QuerySnapshot<Object?>> fetchALlMedicines() {
    return _medicine.snapshots();
  }
}
