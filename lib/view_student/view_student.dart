import 'package:flutter/material.dart';
import 'package:student_recod_app/home.dart/screen_home.dart';

// ignore: must_be_immutable
class ViewStudent extends StatefulWidget {
  ViewStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.address,
      required this.phone,
      required this.docid});
  String name;
  String age;
  String address;
  String phone;
  // ignore: prefer_typing_uninitialized_variables
  final docid;

  @override
  State<ViewStudent> createState() => ViewStudentState();
}

class ViewStudentState extends State<ViewStudent> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.name;
    _ageController.text = widget.age;
    _addressController.text = widget.address;
    _phoneController.text = widget.phone;
  }

  void updateStudent({required docid}) {
    final data = {
      'name ': _nameController.text,
      'age': _ageController.text,
      'address': _addressController.text,
      'phone number': int.parse(_phoneController.text),
    };
    student.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Update Student"),
          backgroundColor: Colors.blueAccent),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEr1Lpwi6g3cM9Ytmr8CZ8oE9BDfeh46qdqA&usqp=CAU'),
                  ),
                  // Stack(
                  //   children: [
                  //     _photo?.path == null
                  //         ? const CircleAvatar(
                  //             radius: 60,
                  //             backgroundColor: Colors.green,
                  //             child: CircleAvatar(
                  //               radius: 57,
                  //               backgroundImage:
                  //                   AssetImage('lib/assest/ani.jpg'),
                  //             ),
                  //           )
                  //         : CircleAvatar(
                  //             radius: 60,
                  //             child: CircleAvatar(
                  //               radius: 58,
                  //               backgroundImage: FileImage(
                  //                 File(
                  //                   _photo!.path,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //     Positioned(
                  //       bottom: 0,
                  //       right: 0,
                  //       child: Container(
                  //         height: 40,
                  //         width: 40,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Color.fromARGB(255, 14, 14, 14),
                  //         ),
                  //         padding: const EdgeInsets.all(4),
                  //         child: Container(
                  //           decoration: const BoxDecoration(
                  //               shape: BoxShape.circle, color: Colors.white),
                  //           child: Icoon(
                  //             icon: const Icon(Icons.camera_alt_outlined),
                  //             padding: EdgeInsets.zero,
                  //             onPressed: () {
                  //               // getPhoto();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  TextFormField(
                    readOnly: true,
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
                    readOnly: true,
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
                    readOnly: true,
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
                    readOnly: true,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // File? _photo;
  // Future<void> getPhoto() async {
  //   final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (photo == null) {
  //   } else {
  //     final photoTemp = File(photo.path);
  //     setState(
  //       () {
  //         _photo = photoTemp;
  //       },
  //     );
  //   }
  // }
}
