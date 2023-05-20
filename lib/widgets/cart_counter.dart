import 'package:flutter/material.dart';

class CartCounter extends StatelessWidget {
  final String count;
  const CartCounter({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 143, 142, 206),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 7),
        ),
      ),
    );
  }
}
