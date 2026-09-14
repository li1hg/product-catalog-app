
import 'package:flutter/material.dart';

import 'ProductManager.dart';
import 'card.dart';

class Homescreen extends StatefulWidget {

  const Homescreen({
    super.key,
  });

  @override
  State<Homescreen> createState() {

    return _HomescreenState();
  }
}


class _HomescreenState
    extends State<Homescreen> {

  DataManager controller =
      DataManager();

  TextEditingController searchController =
      TextEditingController();

  ScrollController scrollController =
      ScrollController();

  bool refreshing = false;


  @override
  void initState() {

    super.initState();

    controller.loadProducts();

    scrollController.addListener(loadMore);
  }


  @override
  void dispose() {

    searchController.dispose();

    scrollController.dispose();

    controller.dispose();

    super.dispose();
  }


  // Check if user is near the bottom
  void loadMore() {

    if (refreshing) {
      return;
    }

    if (controller.loading) {
      return;
    }

    if (controller.loadingMore) {
      return;
    }

    if (!controller.hasMore) {
      return;
    }

    if (!scrollController.hasClients) {
      return;
    }

    double currentPosition =
        scrollController.position.pixels;

    double maxPosition =
        scrollController.position.maxScrollExtent;

    if (currentPosition <
        maxPosition - 300) {

      return;
    }

    controller.loadMore();
  }


  Future<void> refreshProducts() async {

    refreshing = true;

    await controller.refreshProducts();

    if (scrollController.hasClients) {

      scrollController.jumpTo(0);
    }

    refreshing = false;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Li Product Catalog App',

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      body: Column(

        children: [

          // Search box
          Padding(

            padding:
                const EdgeInsets.all(16),

            child: TextField(

              controller:
                  searchController,

              onChanged: (text) {

                setState(() {});
              },

              onSubmitted: (text) {

                controller.search(text);
              },

              decoration:
                  InputDecoration(

                hintText:
                    'Search products...',

                prefixIcon:
                    IconButton(

                  icon:
                      const Icon(
                    Icons.search,
                  ),

                  onPressed: () {

                    controller.search(
                      searchController.text,
                    );
                  },
                ),

                suffixIcon:
                    getClearButton(),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              // Show search button on keyboard
              textInputAction:
                  TextInputAction.search,
            ),
          ),


          // Product list
          Expanded(

            child: ListenableBuilder(

              listenable:
                  controller,

              builder:
                  (context, child) {

                return buildProductList();
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget? getClearButton() {

    if (searchController.text.isEmpty) {
      return null;
    }

    return IconButton(

      icon:
          const Icon(
        Icons.clear,
      ),

      onPressed: () {

        searchController.clear();

        setState(() {});

        controller.search('');
      },
    );
  }


  // Build product list
  Widget buildProductList() {

    if (controller.loading) {

      return const Center(

        child:
            CircularProgressIndicator(),
      );
    }


    if (controller.error) {

      return Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Text(
              'Unable to load products',
            ),

            const SizedBox(
              height: 10,
            ),

            ElevatedButton(

              onPressed:
                  controller.loadProducts,

              child:
                  const Text(
                'Retry',
              ),
            ),
          ],
        ),
      );
    }


    if (controller.products.isEmpty) {

      return const Center(

        child: Text(

          'No products found',

          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }


    return RefreshIndicator(

      onRefresh:
          refreshProducts,

      child: GridView.builder(

        controller:
            scrollController,

        padding:
            const EdgeInsets.all(16),

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,

          crossAxisSpacing: 10,

          mainAxisSpacing: 10,

          childAspectRatio: 0.7,
        ),

        itemCount:
            getItemCount(),

        itemBuilder:
            (context, index) {

          return buildProductItem(index);
        },
      ),
    );
  }


  int getItemCount() {

    int count =
        controller.products.length;

    if (controller.loadingMore) {

      count = count + 2;
    }

    return count;
  }


  Widget buildProductItem(int index) {

    int productCount =
        controller.products.length;

    if (index >= productCount) {

      return const Center(

        child:
            CircularProgressIndicator(),
      );
    }


    CardDesign card =
        CardDesign(

      product:
          controller.products[index],
    );

    return card;
  }
}

