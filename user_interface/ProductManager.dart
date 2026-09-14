
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../api_connect/product_api.dart';
import '../data_convert/json_convert.dart';

class DataManager extends ChangeNotifier {

  ProductApi api = ProductApi();

  List<Product> products = [];
  List<Product> allProducts = [];

  Timer? searchTimer;

  bool loading = true;
  bool loadingMore = false;
  bool error = false;
  bool hasMore = true;

  String searchText = '';

  int skip = 0;
  int limit = 20;

  Future<void> loadProducts() async {

    loading = true;
    loadingMore = false;
    error = false;
    products = [];
    allProducts = [];
    skip = 0;
    hasMore = true;

    notifyListeners();

    try {
      List<Product> result =
          await api.callMultipleProducts(
        limit: limit,
        skip: 0,
      );

      products = result;
      allProducts = result;
      skip = result.length;
      loading = false;

      if (result.length == limit) {
        hasMore = true;
      } else {
        hasMore = false;
      }
      notifyListeners();

    } catch (e) {

      loading = false;
      error = true;

      notifyListeners();
    }
  }


  Future<void> loadMore() async {
  if (loading || loadingMore || !hasMore) {
    return;
  }

  if (searchText.isNotEmpty) {
    return;
  }

  loadingMore = true;
  notifyListeners();

  try {
    final newProducts = await api.callMultipleProducts(
      limit: limit,
      skip: skip,
    );

    products.addAll(newProducts);
    allProducts.addAll(newProducts);

    skip = skip + newProducts.length;

    loadingMore = false;

    if (newProducts.length < limit) {
      hasMore = false;
    }

    notifyListeners();
  } catch (e) {
    loadingMore = false;

    notifyListeners();
  }
}


  void search(String text) {

    searchTimer?.cancel();
    searchTimer = Timer(
      const Duration(milliseconds: 500),
      () async {

        searchText =
            text.trim();

        if (searchText.isEmpty) {
          products =
              List.from(allProducts);

          notifyListeners();

          return;
        }

        loading = true;
        error = false;

        notifyListeners();

        try {
          List<Product> result =
              await api.searchProducts(
            searchText,
          );

          products = result;
          loading = false;

          notifyListeners();

        } catch (e) {

          loading = false;
          error = true;
          notifyListeners();
        }
      },
    );
  }



  Future<void> refreshProducts() async {
  if (searchText.isEmpty) {
    await loadProducts();
  } else {
    searchTimer?.cancel();

    loading = true;
    error = false;

    notifyListeners();

    try {
      final result = await api.searchProducts(
        searchText,
      );

      products = result;

      loading = false;

      notifyListeners();
    } catch (e) {
      loading = false;
      error = true;

      notifyListeners();
    }
  }
}


  @override
  void dispose() {
    searchTimer?.cancel();
    super.dispose();
  }
}