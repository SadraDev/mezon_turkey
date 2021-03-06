import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const String id = 'admin_screen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  File? file;
  String fileName = 'no file selected';
  String description = '';
  String price = '';
  String code = '';
  String size = '';
  UploadTask? task;
  bool shoeValue = true;
  bool clothValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black54,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Mezon Turkey',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.black54,
                  ),
                ),
                onTap: pickFile,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              children: [
                ListTile(
                  leading: const Text('image name : '),
                  minLeadingWidth: 87,
                  title: TextField(
                    maxLength: 20,
                    cursorColor: Colors.lightBlueAccent,
                    cursorHeight: 25,
                    cursorRadius: const Radius.circular(10),
                    decoration: InputDecoration(
                      hintText: fileName,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      fileName = newValue;
                    },
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Text('gimat : '),
                  minLeadingWidth: 87,
                  title: TextField(
                    cursorColor: Colors.lightBlueAccent,
                    cursorHeight: 25,
                    cursorRadius: const Radius.circular(10),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      price = newValue;
                    },
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Text('size : '),
                  minLeadingWidth: 87,
                  title: TextField(
                    cursorColor: Colors.lightBlueAccent,
                    cursorHeight: 25,
                    cursorRadius: const Radius.circular(10),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      size = newValue;
                    },
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Text('tozihat : '),
                  minLeadingWidth: 87,
                  title: TextField(
                    cursorColor: Colors.lightBlueAccent,
                    cursorHeight: 25,
                    cursorRadius: const Radius.circular(10),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      description = newValue;
                    },
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Text('code : '),
                  minLeadingWidth: 87,
                  title: TextField(
                    cursorColor: Colors.lightBlueAccent,
                    cursorHeight: 25,
                    cursorRadius: const Radius.circular(10),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      code = newValue;
                    },
                  ),
                  dense: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('Kafsh : '),
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.lightBlueAccent,
                      value: shoeValue,
                      onChanged: (value) {
                        shoeValue = true;
                        clothValue = false;
                        setState(() {});
                      },
                    ),
                    const Text('Lebas : '),
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.lightBlueAccent,
                      value: clothValue,
                      onChanged: (value) {
                        clothValue = true;
                        shoeValue = false;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          MaterialButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'send',
                  style: TextStyle(color: Colors.black54),
                ),
                task != null ? buildUploadStatus(task!) : Container(),
              ],
            ),
            color: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              if (fileName == 'no file selected' && size == '' && price == '') {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    content: Text(
                      '???????? ?????? ???????? ????????????',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                uploadFile();
                firebaseInstance.collection('products').doc(fileName).set({
                  'code': code,
                  'description': description,
                  'image': 'products image/$fileName',
                  'size': size,
                  'price': price,
                  'isShoe': shoeValue,
                  'isCloth': clothValue,
                  'fileName': fileName,
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      String path = result.files.single.path!;
      fileName = result.files.single.name;

      setState(() => file = File(path));
    }
  }

  Future uploadFile() async {
    if (file == null) return;

    final destination = 'products image/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
  }

  Widget buildUploadStatus(UploadTask task) {
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toString();

          return Text(
            '  $percentage %',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException {
      return null;
    }
  }
}
