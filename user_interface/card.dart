import 'package:flutter/material.dart';

import '../data_convert/json_convert.dart';
import 'detail_interface.dart';

class CardDesign extends StatelessWidget {
  final Product product;

  const CardDesign({
    super.key,
    required this.product,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DetailInterface(
                productId: product.id,
              ),
            ),
          );
        },

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // Product image
            Expanded(
              child: Image.network(
                product.thumbnail,

                width: double.infinity,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            // Product information
            Padding(
              padding: const EdgeInsets.all(8),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    product.title,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '⭐ ${product.rating}',
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'RM ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}