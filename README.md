# product-catalog-app

Project Structure
lib/
├── api_connect/
│   └── product_api.dart
│
├── data_convert/
│   └── json_convert.dart
│
├── user_interface/
│   ├── home_screen.dart
│   ├── card.dart
│   ├── detail_interface.dart
│   └── ProductManager.dart
│
└── main.dart

Code Explanation

[main.dart]
Lines 1–3: Import Flutter and the home screen.
Lines 5–7: Start the Flutter application.
Lines 9–12: Create the main application widget.
Lines 14–24: Set the app theme and title.
Line 26: Set the home screen as the starting screen.

[json_convert.dart]
Lines 1–8: Define the Product model and its properties.
Lines 10–18: Create a Product object using product information.
Lines 20–29: Convert JSON API data into Product object.

[product_api.dart]
Lines 1–3: Import packages
Lines 5–6: Create the API class and set the base URL.
Lines 9–28: Get multiple products from the API.
Lines 32–59: Search products using the API.
Lines 64–76: Get one product by its ID.

[ProductManager.dart]
Lines 1–5: Import required libraries and API files.
Lines 7–18: Store products, loading states, search data, and pagination data.
Lines 21–54: Load the first group of products.
Lines 57–91: Load more products when needed.
Lines 94–130: Handle product searching.
Lines 133–161: Refresh products or search results.
Lines 164–168: Clean up the search timer when finished.

[home_screen.dart]
Lines 1–4: Import Flutter and required project files.
Lines 6–16: Create the home screen.
Lines 19–31: Start product loading and scroll detection.
Lines 34–58: Dispose controllers when the screen closes.
Lines 61–91: Detect when the user is near the bottom of the list.
Lines 94–103: Refresh products and move the screen to the top.
Lines 107–156: Build the app bar, search bar, and product area.
Lines 159–181: Show and handle the search clear button.
Lines 185–231: Handle loading, error, empty, and product list states.
Lines 234–245: Calculate the number of items in the grid.
Lines 249–266: Create each product card.

[card.dart]
Lines 1–4: Import Flutter, Product data, and the detail screen.
Lines 6–12: Create the product card widget.
Lines 14–30: Build the card and open the detail screen when tapped.
Lines 32–45: Display the product image.
Lines 47–72: Display the product title, rating, and price.

[detail_interface.dart]
Lines 1–4: Import Flutter, Product data, and API functions.
Lines 6–20: Create the product detail screen and store the product ID.
Lines 23–47: Load the selected product from the API.
Lines 50–60: Build the detail screen and app bar.
Lines 63–82: Handle loading, error, and missing product states.
Lines 84–105: Build the product detail layout.
Lines 107–135: Display product images.
Lines 138–147: Display the product name.
Lines 150–162: Display the product price.
Lines 165–176: Display the product rating.
Lines 179–200: Display the product description.
