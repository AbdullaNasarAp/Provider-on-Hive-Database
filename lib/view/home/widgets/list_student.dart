import 'dart:io';
import 'package:flutter/material.dart';
import 'package:providerdata/model/functions/db_functions.dart';
import 'package:providerdata/model/model/data_model.dart';

import 'student_full_details.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
            itemBuilder: ((ctx, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                ),
                title: Text(
                  data.name,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(data.place,
                    style: const TextStyle(color: Colors.white)),
                trailing: IconButton(
                  onPressed: () {
                    deleteStudent(index);
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red[900],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => FullDetails(
                            name: data.name,
                            age: data.age,
                            phone: data.phone,
                            place: data.place,
                            photo: data.photo,
                            index: index,
                          )),
                    ),
                  );
                },
              );
            }),
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        },
      ),
    );
  }
}
