
import 'package:flutter/material.dart';
import '../data_convert/json_convert.dart';
import '../api_connect/product_api.dart';

// ignore: must_be_immutable
class DetailInterface extends StatefulWidget {

  int productId;
  DetailInterface({
    super.key,
    required this.productId,
  });

  @override
  State<DetailInterface> createState() {
    return _DetailInterfaceState();
  }
}

class _DetailInterfaceState
    extends State<DetailInterface> {

  ProductApi api = ProductApi();
  Product? product;
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    super.initState();

    loadProduct();
  }

  Future<void> loadProduct() async {

    loading = true;
    error = false;

    setState(() {});

    try {
      Product result =
          await api.callproduct(
        widget.productId,
      );
      product = result;
      loading = false;

      setState(() {});

    } catch (e) {

      loading = false;
      error = true;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
        ),
      ),

      body: buildBody(),
    );
  }

  // Decide what to show
  Widget buildBody() {

    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error) {
      return buildErrorScreen();
    }

    if (product == null) {
      return const Center(
        child: Text(
          'Product not found',
        ),
      );
    }

    // Show product
    return productDetails(product!);
  }

  Widget buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          const Text(
            'Failed to load product',
          ),

          const SizedBox(
            height: 10,
          ),

          ElevatedButton(
            onPressed: loadProduct,
            child: const Text(
              'Retry',
            ),
          ),
        ],
      ),
    );
  }

  // Show product details
  Widget productDetails(Product product) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          buildImages(product),
          const SizedBox(
            height: 20,
          ),

          buildProductName(product),
          const SizedBox(
            height: 10,
          ),

          buildPrice(product),
          const SizedBox(
            height: 10,
          ),

          buildRating(product),
          const SizedBox(
            height: 20,
          ),

          const Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),
          buildDescription(product),
        ],
      ),
    );
  }

  // Build product images
  Widget buildImages(Product product) {

    return SizedBox(
      height: 280,
      child: PageView.builder(
        itemCount:
            product.images.length,

        itemBuilder:
            (context, index) {
          String imageUrl =
              product.images[index];

          return ClipRRect(
            borderRadius:
                BorderRadius.circular(12),

            child: Image.network(
              imageUrl,

              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return const Center(

                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Build product name
  Widget buildProductName(Product product) {

    return Text(
      product.title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight:
            FontWeight.bold,
      ),
    );
  }

  // Build product price
  Widget buildPrice(Product product) {

    String price =
        product.price.toStringAsFixed(2);
    return Text(
      'RM $price',
      style: const TextStyle(
        fontSize: 24,
        fontWeight:
            FontWeight.bold,
        color: Colors.red,
      ),
    );
  }

  // Build product rating
  Widget buildRating(Product product) {

    String rating =
        product.rating.toStringAsFixed(1);
    return Text(
      '⭐ $rating',
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }

  // Build description box
  Widget buildDescription(Product product) {

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Colors.grey.shade100,
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
      ),

      child: Text(
        product.description,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}
