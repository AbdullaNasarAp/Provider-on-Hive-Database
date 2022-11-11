import 'dart:io';
import 'package:flutter/material.dart';

import 'edit_student.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({
    Key? key,
    required this.name,
    required this.age,
    required this.phone,
    required this.place,
    required this.photo,
    required this.index,
  }) : super(
          key: key,
        );
  final String name;
  final String age;
  final String phone;
  final String place;
  final String photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: const Center(
            child: Text(
              'Full Details Of Student',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditStudent(
                        age: age,
                        place: place,
                        index: index,
                        name: name,
                        phone: phone,
                        image: photo,
                        photo: '',
                      )),
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
          backgroundColor: const Color.fromARGB(255, 9, 7, 14),
          label: const Text(
            'Edit',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CircleAvatar(
                    radius: 200,
                    backgroundImage: FileImage(
                      File(
                        photo,
                      ),
                    ),
                  ),
                ),
                Data(name: name, age: age, phone: phone, place: place)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Data extends StatelessWidget {
  const Data(
      {Key? key,
      required this.name,
      required this.age,
      required this.phone,
      required this.place})
      : super(key: key);
  final String name;
  final String age;
  final String phone;
  final String place;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 90,
        child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "Full name: $name",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Age: $age",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Phone Number: $phone",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "place: $place",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
