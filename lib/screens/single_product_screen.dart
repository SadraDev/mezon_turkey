import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mezon_turkey/custom%20drawer%20screens/shopping_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

final CollectionReference singleScreen =
    FirebaseFirestore.instance.collection('products');

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({
    Key? key,
    required this.document,
  }) : super(key: key);

  final Map document;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                future: firebase_storage.FirebaseStorage.instance
                    .ref(document['image'])
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data.toString()),
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: 120,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Text('loading...'));
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: Text('no connection :( '));
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    leading: const Text('tozihat: '),
                    title: Text(document['description']),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Text('gimat: '),
                    title: Text(document['price'] + ' T'),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Text('size: '),
                    title: Text(document['size']),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Text('code: '),
                    title: Text(document['code']),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
                elevation: 5,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'افزودن به سبد خرید',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              onPressed: () {
                ShoppingList.buyingList.add(document);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'به سبد خرید اضافه شد',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
