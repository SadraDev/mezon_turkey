// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);
  static List buyingList = [];
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
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
      body: ListView.builder(
        itemCount: ShoppingList.buyingList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              dense: true,
              leading: SizedBox(
                height: 250,
                width: 100,
                child: FutureBuilder(
                  future: firebase_storage.FirebaseStorage.instance
                      .ref(ShoppingList.buyingList[index]['image'])
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return const Center(child: Text('no connection :( '));
                    }
                    return const Text('');
                  },
                ),
              ),
              title: Text(ShoppingList.buyingList[index]['description']),
              subtitle: Text(ShoppingList.buyingList[index]['price']),
              onLongPress: () {
                Alert(
                  context: context,
                  type: AlertType.none,
                  title: "!حذف",
                  desc: "آیا میخواهید از سبد حذف کنید؟",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "حذف",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        ShoppingList.buyingList.removeAt(index);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      width: 120,
                      color: Colors.red,
                    ),
                    DialogButton(
                      child: Text(
                        "لغو",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 120,
                      color: Colors.green,
                    )
                  ],
                ).show();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('خرید'),
            SizedBox(width: 24),
            Icon(Icons.shopping_bag_outlined),
          ],
        ),
        onPressed: () {
          //TODO: redirect to payment page
          FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}
