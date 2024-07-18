import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../model/products_model.dart';
import '../../../utils/colors/app_color.dart';
class ProductDetails extends StatelessWidget {
  final Product product;
  final bool showDiscountPrice;
  const ProductDetails(
      {super.key, required this.product, required this.showDiscountPrice});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: AppColors.white,
      shape: BoxShape.rectangle,
      shadowColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: PhysicalModel(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail!,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                    placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 16, bottom: 4, right: 5),
                    child: Text(
                      product.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                product.description!,
                style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            (showDiscountPrice)
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 1.0, vertical: 1),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '\$${product.price}',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '\$${(product.price! * (1 - product.discountPercentage! / 100)).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: AppColors.secondaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '${product.discountPercentage!.toStringAsFixed(2)}% off',
                        style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff44fc3c),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 1.0, vertical: 1),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '\$${product.price!}',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
