import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rubberx/NewsShoppingChat/Models/product_model.dart';
import 'package:rubberx/NewsShoppingChat/shopping_cart_page.dart';
import 'package:rubberx/NewsShoppingChat/shopping_view_product.dart';

class ShoppingProducts extends StatefulWidget {
  const ShoppingProducts({super.key});

  @override
  State<ShoppingProducts> createState() => _ShoppingProductsState();
}

class _ShoppingProductsState extends State<ShoppingProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShoppingCartPage()));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Data is available
            final products = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                ProductModel productModel = ProductModel.fromMap(
                    products[index].data() as Map<String, dynamic>);

                return productCard(
                  title: productModel.title,
                  description: productModel.description,
                  price: productModel.price,
                  image: productModel.image,
                  id: productModel.id,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget productCard(
      {required String title,
      required String description,
      required double price,
      required String image,
      required String id}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShoppingViewProduct(
              productModel: ProductModel(
                id: id,
                title: title,
                description: description,
                price: price,
                image: image,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(19, 19, 19, 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              image,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              price.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
