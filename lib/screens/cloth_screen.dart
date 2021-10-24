// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mezon_turkey/CustomStuff/bubbles.dart';
import 'package:mezon_turkey/screens/single_product_screen.dart';

class ClothScreen extends StatelessWidget {
  ClothScreen({Key? key, required this.isChecked}) : super(key: key);
  final bool isChecked;

  final Stream<QuerySnapshot> _clothStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _clothStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
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

            final newChild = Bubble(
              networkImage: networkImage,
              description: description,
              price: price,
              size: size,
              onTap: onTap,
              color: color,
            );

            if (data[i]['isCloth'] == true) {
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
