import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductDisplayWidget extends StatefulWidget {
  const ProductDisplayWidget({super.key});

  @override
  State<ProductDisplayWidget> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    var myProducts = context.watch<CartProvider>().myProduct;
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      physics: const BouncingScrollPhysics(),
      crossAxisSpacing: 15,
      crossAxisCount: 2,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return singleItemWidget(
          products[index],
          index == products.length - 1 ? true : false,
          myProducts,
        );
      },
    );
  }

  Widget singleItemWidget(
      Product currentProduct, bool lastItem, List<Product> products) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Column(
        children: [
          Stack(
            children: [
              Container(
                height: 350.sp, //
                padding: EdgeInsets.all(3.sp), //
                margin: EdgeInsets.all(8.sp), //
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(1, 1),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: CachedNetworkImage(
                        imageUrl: currentProduct.productImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 10.0),
                      child: Text(
                        currentProduct.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          Text("\$${currentProduct.currentPrice}"),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 8.0, top: 10.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (!products.contains(currentProduct)) {
                                value.addToCart(currentProduct);
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 143, 142, 206),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(192, 192, 192, 0.8),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    currentProduct.isLiked == true
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: lastItem == true
                ? MediaQuery.of(context).size.height * 0.50
                : 0,
          )
        ],
      ),
    );
  }
}
