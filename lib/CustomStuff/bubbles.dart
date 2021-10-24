import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    Key? key,
    required this.networkImage,
    required this.description,
    required this.price,
    required this.size,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final String networkImage;
  final String description;
  final String price;
  final String size;
  final bool color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: color ? Colors.grey[600] : Colors.grey[300],
          ),
          child: Column(
            children: [
              FutureBuilder(
                future: firebase_storage.FirebaseStorage.instance
                    .ref(networkImage)
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
              const SizedBox(
                height: 8,
              ),
              Text(description),
              const SizedBox(
                height: 4,
              ),
              Text(price + ' T'),
              const SizedBox(
                height: 4,
              ),
              Text(size),
            ],
          ),
        ),
      ),
    );
  }
}
