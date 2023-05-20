import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _myProduct = [];
  List<Product> get myProduct => _myProduct;
  Box<Product> cartBox = Hive.box("cart");

  double get subTotal {
    double subTotal = _myProduct.fold(
      0,
      (total, current) => total + int.parse(current.currentPrice),
    );
    return subTotal;
  }

  void addToCart(Product product) {
    _myProduct.add(product);
    cartBox.put(product.productName, product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _myProduct.remove(product);
    cartBox.delete(product.productName);
    notifyListeners();
  }
}
