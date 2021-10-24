import 'package:mezon_turkey/screens/single_product_screen.dart';
import 'package:mezon_turkey/CustomStuff/bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoeScreen extends StatelessWidget {
  ShoeScreen({Key? key, required this.isChecked}) : super(key: key);
  final bool isChecked;

  final Stream<QuerySnapshot> _shoeStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _shoeStream,
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

        List<Widget> children = [];

        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
          for (int i = 0; i < data.length; i++) {
            String networkImage = data[i]['image'];
            String description = data[i]['description'];
            String price = data[i]['price'];
            String size = data[i]['size'];
            bool color = isChecked;
            void Function()? onTap() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleProductScreen(
                    document: data[i].data() as Map<String, dynamic>,
                  ),
                ),
              );
            }

            void Function()? onLongPress() {
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
                              .doc(data[i]['fileName'])
                              .delete();
                          Navigator.pop(context);
                        },
                        child: const Text('delete'),
                      ),
                    ],
                  ),
                );
              }
            }

            final newChild = Bubble(
              networkImage: networkImage,
              description: description,
              price: price,
              size: size,
              onTap: onTap,
              color: color,
              onLongPress: onLongPress,
            );

            if (data[i]['isShoe'] == true) {
              children.add(newChild);
            }
          }
        }

        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.9,
            crossAxisCount: 2,
          ),
          children: children,
        );
      },
    );
  }
}
