import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // Function to remove an item from the cart
  void removeItem(String itemId) {
    FirebaseFirestore.instance.collection('cart').doc(itemId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No items in cart',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            // Data is available
            final items = snapshot.data!.docs;
            log('items.length: ${items.length}');
            final itemList = items
                .map((item) => item.data() as Map<String, dynamic>)
                .toList();
            return Column(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Title',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Price',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  rows: itemList
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                item['title'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['price'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.delete_forever_rounded),
                                color: Colors.red,
                                onPressed: () {
                                  final itemId =
                                      items[itemList.indexOf(item)].id;
                                  removeItem(itemId);
                                  log('item: $itemId');
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Total: Rs. ${itemList.fold(0.0, (sum, item) => sum + (item['price'] as double))}/=',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white12,
                  ),
                  child: const Text('Checkout'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
