import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Box<Product> cartBox;

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<Product>('cart');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Column(
                children: [
                  const Text(
                    'Your Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  Consumer<CartProvider>(
                      builder: (context, value, child) => Column(
                            children: [
                              Text(
                                '${cartBox.values.length} items',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )),
                ],
              ),
            ),
            backgroundColor: Colors.grey,
          ),
          body: ValueListenableBuilder(
            valueListenable: cartBox.listenable(),
            builder: (context, Box<Product> product, child) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: product.length,
                itemBuilder: (_, index) {
                  final currentProduct = product.values.toList()[index];
                  return Card(
                    key: ValueKey(currentProduct.productName),
                    elevation: 4,
                    child: ListTile(
                      leading: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: currentProduct.productImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(currentProduct.productName),
                      subtitle: Text("\$${currentProduct.currentPrice}"),
                      trailing: TextButton(
                        onPressed: (() {
                          value.removeFromCart(currentProduct);
                        }),
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          bottomNavigationBar: Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xFFDADADA).withOpacity(0.15),
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${value.subTotal}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 160,
                    height: 65,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 143, 142, 206),
                      borderRadius: BorderRadius.all(
                        Radius.circular(36),
                      ),
                    ),
                    child: const Text(
                      'BUY NOW',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
