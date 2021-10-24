import 'package:mezon_turkey/screens/single_product_screen.dart';
import 'package:mezon_turkey/CustomStuff/bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> _homeStream =
    FirebaseFirestore.instance.collection('products').snapshots();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.isChecked}) : super(key: key);
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _homeStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.lightBlueAccent),
          );
        }

        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.9,
            crossAxisCount: 2,
          ),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Bubble(
              networkImage: data['image'],
              description: data['description'],
              price: data['price'],
              size: data['size'],
              color: isChecked,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleProductScreen(
                      document: document.data() as Map<String, dynamic>,
                    ),
                  ),
                );
              },
              onLongPress: () {
                if (FirebaseAuth.instance.currentUser!.uid.toString() ==
                    'ViDaBMnGY0dnI32oKXKk9QXgXCY2') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text(
                          'Are your sure you want to delete the product?'),
                      title: const Text('Delete'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('no'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(data['fileName'])
                                .delete();
                            Navigator.pop(context);
                          },
                          child: const Text('delete'),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }).toList(),
        );
      },
    );
  }
}
