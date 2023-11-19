// import 'package:flutter/material.dart';
// import 'package:the_best_furniture/models/user.dart';
// import 'package:the_best_furniture/pages/user/cart_page.dart';
// import 'package:the_best_furniture/providers/navigation.dart';
// import 'package:the_best_furniture/providers/screen_size.dart';

// class ProductDetail extends StatefulWidget {
//   final User user;
//   String id;
//   String name;
//   String color;
//   String image;
//   String category;
//   String description;
//   int price;
//   int stock;

//   ProductDetail({
//     super.key,
//     required this.user,
//     required this.id,
//     required this.name,
//     required this.color,
//     required this.image,
//     required this.category,
//     required this.description,
//     required this.price,
//     required this.stock,
//   });

//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Image.network(
//             widget.image,
//             height: ScreenSize.screenHeight / 2,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.name,
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   widget.category,
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   widget.color,
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   widget.description,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Price: \$${widget.price.toString()}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Stock: ${widget.stock.toString()} units',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (widget.stock > 0) {
//                       Navigation.goto(context, CartPage(user: User()));
//                     } else {}
//                   },
//                   child: Text('Buy Now'),
//                 ),
//                 SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     widget.user.addToCart(widget.id);
//                   },
//                   child: Text('addTocart'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
