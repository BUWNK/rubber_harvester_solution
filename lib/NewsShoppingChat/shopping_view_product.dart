import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rubberx/NewsShoppingChat/Models/product_model.dart';
import 'package:rubberx/NewsShoppingChat/shopping_cart_page.dart';

class ShoppingViewProduct extends StatefulWidget {
  final ProductModel productModel;

  const ShoppingViewProduct({super.key, required this.productModel});

  @override
  State<ShoppingViewProduct> createState() => _ShoppingViewProductState();
}

class _ShoppingViewProductState extends State<ShoppingViewProduct> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addToCart() async {
    await _firestore
        .collection('cart')
        // .doc(widget.productModel.id).
        .doc()
        .set({
      'title': widget.productModel.title,
      'image': widget.productModel.image,
      'price': widget.productModel.price,
      'description': widget.productModel.description,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Item added to cart successfully!',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Color.fromRGBO(21, 21, 21, 1.0),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Product',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              Image.network(widget.productModel.image),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.productModel.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.productModel.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rs. ${widget.productModel.price}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addToCart();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white12,
                ),
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
