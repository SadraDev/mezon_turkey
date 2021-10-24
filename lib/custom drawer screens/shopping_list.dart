import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
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
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() => ShoppingList.buyingList.removeAt(index));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text('خرید'),
            SizedBox(width: 24),
            Icon(Icons.shopping_bag_outlined),
          ],
        ),
        onPressed: () {
          //TODO: redirect to payment page
        },
      ),
    );
  }
}
