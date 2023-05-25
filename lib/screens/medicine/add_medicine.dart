// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:intern/services/crud_operations.dart';
import 'package:intern/services/notification_service.dart';
import 'package:intern/widgets/widgets.dart';

class AddMedicinePage extends StatefulWidget {
  final String deviceToken;
  const AddMedicinePage({
    Key? key,
    required this.deviceToken,
  }) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  TextEditingController addMedicineController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    addMedicineController.dispose();
  }

  Future addMedicineToDb(String medicine) async {
    await MedicineDbMethods().addToDb(context: context, title: medicine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medicine"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: addMedicineController,
                  label: "Add Medicine",
                  obscureText: false,
                  hintText: "e.g Paracetamol",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input must not be empty";
                    }
                    return null;
                  },
                ),

                // the register button
                const SizedBox(
                  height: 18,
                ),

                CustomButton(
                  color: Colors.blueAccent.shade200,
                  title: "Submit",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      final title = addMedicineController.text;
                      await addMedicineToDb(title).then(
                        (value) => NotificationSettingsMethods()
                            .sendPushNotification(widget.deviceToken),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
