// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_recod_app/home.dart/screen_home.dart';
import 'package:student_recod_app/resources/add_image_to_fire_base.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => AddStudentScreenState();
}

class AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Uint8List? pickedimage;
  String? proImgUrl;

  void addstudent() {
    final data = {
      'name ': _nameController.text,
      'age': _ageController.text,
      'address': _addressController.text,
      'phone number': int.parse(_phoneController.text),
      'url': proImgUrl,
    };
    student.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Student"), backgroundColor: Colors.blueAccent),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      pickedimage == null
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.green,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEr1Lpwi6g3cM9Ytmr8CZ8oE9BDfeh46qdqA&usqp=CAU'),
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                radius: 58,
                                backgroundImage: MemoryImage(pickedimage!),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 14, 14, 14),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                getPhoto();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Name is Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter age',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Age is Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      } else if (value.length < 10) {
                        return ' Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()
                            //  &&
                            //     _photo != null
                            ) {
                          try {
                            proImgUrl = await StoreImage.uploadImageToStorage(
                                img: pickedimage!, imgnName: imagename);
                            addstudent();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } catch (e) {
                            // ignore: avoid_print
                            print('hellwo error $e');
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }
                        // else if (_photo == null) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //           backgroundColor: Colors.red,
                        //           content: Text(
                        //             'Please add profile image!',
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //             ),
                        //           )));
                        // }
                        else {
                          // ignore: avoid_print
                          print('Empty field found');
                        }
                      },
                      child: const Text('Add Student')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Uint8List? selectedImageInBites;
  // File? _photo;
  Future<void> getPhoto() async {
    print('hi');
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
    imagename = filePickerResult!.files.first.name;

    pickedimage = filePickerResult!.files.first.bytes;

    setState(() {});
  }

  String imagename = '';
}
