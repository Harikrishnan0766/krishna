// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_recod_app/addstudent/add.dart';
import 'package:student_recod_app/search/search.dart';
import 'package:student_recod_app/update_student/update_student.dart';
import 'package:student_recod_app/view_student/view_student.dart';

deleteStudent({required final docId}) {
  student.doc(docId).delete();
}

final CollectionReference student =
    FirebaseFirestore.instance.collection('student');

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Map<String, dynamic>> students = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddStudentScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Student db",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    students: students,
                  ),
                ));
              },
              icon: Icon(Icons.search))
        ],
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: student.orderBy('name ').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            students.clear();
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot studentSnap = snapshot.data!.docs[index];

                students.add({
                  'name ': studentSnap['name '],
                  'age': studentSnap['age'],
                  'address': studentSnap['address'],
                  'phone number': studentSnap['phone number'],
                  'id': studentSnap.id,
                  'url': studentSnap['url'],
                });
                // ignore: avoid_print
                print(studentSnap['url']);
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewStudent(
                      name: studentSnap['name '],
                      age: studentSnap['age'],
                      address: studentSnap['address'],
                      phone: studentSnap['phone number'].toString(),
                      docid: studentSnap.id,
                    ),
                  )),
                  leading: InkWell(
                    onTap: () {
                      print("====================---${studentSnap['url']}");
                    },
                     child: Image.network(studentSnap['url'].toString(),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
                              CircularProgressIndicator(),
                          errorBuilder: (context, error, stackTrace) {
                             print("===========---$stackTrace}");
                            // print('hellow $error hi $stackTrace ');
                            // print(studentSnap['url']);
                            return Image(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEr1Lpwi6g3cM9Ytmr8CZ8oE9BDfeh46qdqA&usqp=CAU'));
                          }),

                    
                    // child: Container(
                    //   height: 50,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //     image: NetworkImage(studentSnap["url"]),
                    //   )),

                      // child: Image.network(studentSnap['url'].toString(),
                      //     fit: BoxFit.cover,
                      //     loadingBuilder: (context, child, loadingProgress) =>
                      //         CircularProgressIndicator(),
                      //     errorBuilder: (context, error, stackTrace) {
                      //       // print('hellow $error hi $stackTrace ');
                      //       // print(studentSnap['url']);
                      //       return Image(
                      //           image: NetworkImage(
                      //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEr1Lpwi6g3cM9Ytmr8CZ8oE9BDfeh46qdqA&usqp=CAU'));
                      //     }),
                    // ),
                  ),
                  title: Text(studentSnap['name ']),
                  subtitle: Text(studentSnap['age']),
                  // ignore: sized_box_for_whitespace
                  trailing: Container(
                    width: 80,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateStudent(
                                  name: studentSnap['name '],
                                  age: studentSnap['age'],
                                  address: studentSnap['address'],
                                  phone: studentSnap['phone number'].toString(),
                                  docid: studentSnap.id,
                                ),
                              ));
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              deleteStudent(docId: studentSnap.id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
