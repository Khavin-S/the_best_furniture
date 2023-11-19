// import 'package:flutter/material.dart';
// import 'package:the_best_furniture/models/user.dart';

// class CartPage extends StatefulWidget {
//   final User user;
//   String? productId;
//   CartPage({super.key,
//   required this.user,
//   this.productId});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Widget'),
//       ),
//       body: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: widget.user.cartItemsStream, // Use the stream from the User class
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Map<String, dynamic>> cartItems = snapshot.data!;
//             return ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(cartItems[index]['productName']),
//                   subtitle: Text('Price: \$${cartItems[index]['productPrice']}'),
//                   // Add any other UI elements you need
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );

//   }
// }