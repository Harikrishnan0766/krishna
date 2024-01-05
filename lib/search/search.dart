import 'package:flutter/material.dart';
import 'package:student_recod_app/home.dart/screen_home.dart';
import 'package:student_recod_app/update_student/update_student.dart';
import 'package:student_recod_app/view_student/view_student.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.students});
  List<Map<String, dynamic>> students = [];

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(hintText: 'Search'),
          controller: textEditingController,
          onChanged: (value) {
            setState(() {
              searchfunction(widget.students, textEditingController.text);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount:
            searchfunction(widget.students, textEditingController.text).length,
        itemBuilder: (context, index) {
          final studentSnap = searchfunction(
              widget.students, textEditingController.text)[index];
          return ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewStudent(
                name: studentSnap['name '],
                age: studentSnap['age'],
                address: studentSnap['address'],
                phone: studentSnap['phone number'].toString(),
                docid: studentSnap['id'],
              ),
            )),
            leading: CircleAvatar(
              child: Image.network(
                studentSnap['url'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    const CircularProgressIndicator(),
                errorBuilder: (context, error, stackTrace) => const Image(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEr1Lpwi6g3cM9Ytmr8CZ8oE9BDfeh46qdqA&usqp=CAU')),
              ),
            ),
            title: Text(studentSnap['name ']),
            subtitle: Text(studentSnap['age']),
            trailing: SizedBox(
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
                            docid: studentSnap['id'],
                          ),
                        ));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        deleteStudent(docId: studentSnap['id']);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          );
          // return ListTile(
          //   title: Text(
          //     searchfunction(widget.students, textEditingController.text)[index]
          //         ['name '],
          //   ),
          // );
        },
      ),
    );
  }

  List<Map<String, dynamic>> searchfunction(
      List<Map<String, dynamic>> studen, String searchText) {
    // ignore: prefer_is_not_empty
    if (!searchText.isEmpty) {
      List<Map<String, dynamic>> mylist = studen
          .where((element) =>
              element['name '].toString().contains(searchText) ||
              element['address'].toString().contains(searchText))
          .toList();
      return mylist;
    } else {
      return studen;
    }
  }
}
