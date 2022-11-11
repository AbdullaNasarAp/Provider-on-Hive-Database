import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerdata/controller/provider/providerstate.dart';
import 'package:providerdata/model/functions/db_functions.dart';
import 'package:providerdata/model/model/data_model.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentsProvider =
        Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      studentsProvider.image = null;
    });
    log("rebuild");
    return Scaffold(
//  AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text('Fill The Details'),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<StudentProvider>(builder: (context, value, child) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: value.image?.path == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.black38,
                                radius: 60,
                                child: Icon(
                                  Icons.image,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(
                                    value.image!.path,
                                  ),
                                ),
                                radius: 60,
                              ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, elevation: 10),
                        onPressed: () {
                          Provider.of<StudentProvider>(context, listen: false)
                              .getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                    ),
                    validator: (
                      value,
                    ) {
                      if (value == null || value.isEmpty) {
                        return 'Required Age ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 10) {
                        return 'Require valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _placeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Place',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Require Place ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          studentsProvider.image != null) {
                        onAddStudentButtonClicked(context);
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black, elevation: 10),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final place = _placeController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        phone.isEmpty ||
        place.isEmpty ||
        Provider.of<StudentProvider>(context, listen: false)
            .image!
            .path
            .isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Sucessfully Student Added .. "),
        ),
      );
    }

    final student = StudentModel(
        name: name,
        age: age,
        phone: phone,
        place: place,
        photo:
            Provider.of<StudentProvider>(context, listen: false).image!.path);
    addStudent(student);
  }
}
