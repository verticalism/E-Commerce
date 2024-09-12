import 'package:flutter/material.dart';
import 'package:vetore/widgets/GridViewProduct.dart';

class ProductPageScreen extends StatelessWidget {
  const ProductPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  child: Text(
                "All Products From Vetore",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )),
              GridViewProductAPI(),
            ],
          ),
        ),
      ),
    );
  }
}
