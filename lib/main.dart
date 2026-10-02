import 'package:flutter/material.dart';

void main() {
  runApp(const ProductNavigationApp());
}

const _navigationBlue = Color(0xFF2196F3);

class ProductNavigationApp extends StatelessWidget {
  const ProductNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _navigationBlue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: _navigationBlue,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const ProductListPage(),
    );
  }
}

class Product {
  const Product({
    required this.name,
    required this.label,
    required this.description,
    required this.price,
    required this.color,
    this.rating = 0,
  });

  final String name;
  final String label;
  final String description;
  final int price;
  final Color color;
  final int rating;
}

const _products = <Product>[
  Product(
    name: 'Pixel',
    label: 'pixel 1',
    description: 'Pixel is the most featureful phone ever',
    price: 800,
    color: Color(0xFF3D63D8),
  ),
  Product(
    name: 'Laptop',
    label: 'laptop',
    description: 'Laptop is most productive development tool',
    price: 2000,
    color: Color(0xFF32D332),
  ),
  Product(
    name: 'Tablet',
    label: 'tablet',
    description: 'Tablet is the most useful device ever for meeting',
    price: 1500,
    color: Color(0xFFD2C92E),
    rating: 3,
  ),
  Product(
    name: 'Pendrive',
    label: 'pen drive',
    description: 'Pendrive is the stylish phone ever',
    price: 100,
    color: Color(0xFFC65B3C),
  ),
  Product(
    name: 'Floppy Drive',
    label: 'floppy drive',
    description: 'A classic drive for storing and sharing files (sample)',
    price: 300,
    color: Color(0xFF36BCA8),
  ),
];

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  void _openProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Navigation')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ProductCard(
            product: product,
            onTap: () => _openProduct(context, product),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, required this.onTap, super.key});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 132,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ProductArtwork(
                  product: product,
                  labelFontSize: 27,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 7,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                      Text(
                        'Price: ${product.price}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      RatingStars(rating: product.rating, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: ProductArtwork(product: product, labelFontSize: 58),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Price: ${product.price}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  RatingStars(rating: product.rating, size: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductArtwork extends StatelessWidget {
  const ProductArtwork({
    required this.product,
    required this.labelFontSize,
    super.key,
  });

  final Product product;
  final double labelFontSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: product.color,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              product.label,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: labelFontSize,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({required this.rating, required this.size, super.key});

  final int rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: const Color(0xFFFF665E),
            size: size,
          ),
        ),
      ),
    );
  }
}
