// *****************************************************************************

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'product.dart';
// import 'constants.dart';
// import 'package:http/http.dart' as http;

// class PrivateScreen extends StatefulWidget {
//   const PrivateScreen({Key? key}) : super(key: key);

//   @override
//   _PrivateScreenState createState() => _PrivateScreenState();
// }

// class _PrivateScreenState extends State<PrivateScreen> {
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('http://$host:3000/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         products =
//             jsonData.map((product) => Product.fromJson(product)).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener productos')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     leading: Checkbox(
//                       activeColor: Colors.orange,
//                       value: product.selected,
//                       onChanged: (value) {
//                         setState(() {
//                           product.selected = value!;
//                         });
//                       },
//                     ),
//                     title: Text(
//                       'Nombre: ${product.name}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Categoría: ${product.category}'),
//                         Text('Precio: ${product.price.toStringAsFixed(2)}'),
//                         Text('Cantidad: ${product.quantity.toString()}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Color.fromARGB(255, 24, 152, 211),
//                           ),
//                           onPressed: () {
//                             _editProduct(product);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Color.fromARGB(255, 226, 76, 66),
//                           ),
//                           onPressed: () {
//                             _deleteProduct(product.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _editProduct(Product product) {
//     // Implementar la lógica de edición del producto aquí
//   }

//   void _deleteProduct(int productId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirmar eliminación'),
//           content:
//               const Text('¿Estás seguro de que deseas eliminar este producto?'),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _performDelete(productId);
//                 fetchProducts();
//               },
//               child: const Text('Eliminar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _performDelete(int productId) async {
//     final url = Uri.parse('http://$host:3000/products/$productId');
//     final response = await http.delete(url);

//     if (response.statusCode == 200) {
//       // El producto se eliminó con éxito, puedes realizar alguna acción adicional si es necesario
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al eliminar el producto')),
//       );
//     }
//   }
// }

// *****************************************************************************

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'product.dart';
// import 'constants.dart';
// import 'package:http/http.dart' as http;

// class PrivateScreen extends StatefulWidget {
//   const PrivateScreen({Key? key}) : super(key: key);

//   @override
//   _PrivateScreenState createState() => _PrivateScreenState();
// }

// class _PrivateScreenState extends State<PrivateScreen> {
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('http://$host:3000/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         products =
//             jsonData.map((product) => Product.fromJson(product)).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener productos')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     leading: Checkbox(
//                       activeColor: Colors.orange,
//                       value: product.selected,
//                       onChanged: (value) {
//                         setState(() {
//                           product.selected = value!;
//                         });
//                       },
//                     ),
//                     title: Text(
//                       'Nombre: ${product.name}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Categoría: ${product.category}'),
//                         Text('Precio: ${product.price.toStringAsFixed(2)}'),
//                         Text('Cantidad: ${product.quantity.toString()}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Color.fromARGB(255, 24, 152, 211),
//                           ),
//                           onPressed: () {
//                             _editProduct(product);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Color.fromARGB(255, 226, 76, 66),
//                           ),
//                           onPressed: () {
//                             _deleteProduct(product.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//        floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Lógica para actualizar la lista de productos
//           fetchProducts();
//         },
//         backgroundColor: Colors.orange, // Cambia el color de fondo del botón a naranja
//         child: const Icon(
//           IconData(0xe514, fontFamily: 'MaterialIcons'), // Icono de actualización
//           color: Colors.white, // Define el color del icono como blanco
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//     );
//   }

//   void _addProduct() {
//   // Implementa la lógica para agregar un producto aquí
//   // Puedes abrir un cuadro de diálogo de adición o navegar a una nueva pantalla para ingresar detalles del producto.
//   // Por ejemplo:
//   // Navigator.push(
//   //   context,
//   //   MaterialPageRoute(
//   //     builder: (context) => AddProductScreen(),
//   //   ),
//   // );
// }

//   void _editProduct(Product product) {
//     // Implementar la lógica de edición del producto aquí
//   }

//   void _deleteProduct(int productId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirmar eliminación'),
//           content:
//               const Text('¿Estás seguro de que deseas eliminar este producto?'),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _performDelete(productId);
//                 fetchProducts();
//               },
//               child: const Text('Eliminar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _performDelete(int productId) async {
//     final url = Uri.parse('http://$host:3000/products/$productId');
//     final response = await http.delete(url);

//     if (response.statusCode == 200) {
//       // El producto se eliminó con éxito, puedes realizar alguna acción adicional si es necesario
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al eliminar el producto')),
//       );
//     }
//   }
// }

// *****************************************************************************

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'add_product_screen.dart';
// import 'product.dart';
// import 'constants.dart';
// import 'package:http/http.dart' as http;

// class PrivateScreen extends StatefulWidget {
//   const PrivateScreen({Key? key}) : super(key: key);

//   @override
//   _PrivateScreenState createState() => _PrivateScreenState();
// }

// class _PrivateScreenState extends State<PrivateScreen> {
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('http://$host:3000/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         products =
//             jsonData.map((product) => Product.fromJson(product)).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener productos')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     leading: Checkbox(
//                       activeColor: Colors.orange,
//                       value: product.selected,
//                       onChanged: (value) {
//                         setState(() {
//                           product.selected = value!;
//                         });
//                       },
//                     ),
//                     title: Text(
//                       'Nombre: ${product.name}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Categoría: ${product.category}'),
//                         Text('Precio: ${product.price.toStringAsFixed(2)}'),
//                         Text('Cantidad: ${product.quantity.toString()}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Color.fromARGB(255, 24, 152, 211),
//                           ),
//                           onPressed: () {
//                             _editProduct(product);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Color.fromARGB(255, 226, 76, 66),
//                           ),
//                           onPressed: () {
//                             _deleteProduct(product.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0), // Relleno de 10 pixeles
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.orange, // Color de fondo naranja
//                   shape: BoxShape.circle, // Opcional: Forma del botón
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     fetchProducts();
//                   },
//                   icon: const Icon(
//                     IconData(0xe514, fontFamily: 'MaterialIcons'),
//                     color: Colors.white, // Color del icono blanco
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0), // Relleno de 10 pixeles
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.green, // Color de fondo naranja
//                   shape: BoxShape.circle, // Opcional: Forma del botón
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     _addProduct();
//                   },
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white, // Color del icono blanco
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _addProduct() {
//     // Implementa la lógica para agregar un producto aquí
//     // Puedes abrir un cuadro de diálogo de adición o navegar a una nueva pantalla para ingresar detalles del producto.
//     // Por ejemplo:
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const AddProductScreen(),
//       ),
//     );
//   }

//   void _editProduct(Product product) {
//     // Implementar la lógica de edición del producto aquí
//   }

//   void _deleteProduct(int productId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirmar eliminación'),
//           content:
//               const Text('¿Estás seguro de que deseas eliminar este producto?'),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _performDelete(productId);
//                 fetchProducts();
//               },
//               child: const Text('Eliminar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _performDelete(int productId) async {
//     final url = Uri.parse('http://$host:3000/products/$productId');
//     final response = await http.delete(url);

//     if (response.statusCode == 200) {
//       // El producto se eliminó con éxito, puedes realizar alguna acción adicional si es necesario
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al eliminar el producto')),
//       );
//     }
//   }
// }

// *****************************************************************************

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'add_product_screen.dart';
// import 'product.dart';
// import 'constants.dart';
// import 'package:http/http.dart' as http;

// class PrivateScreen extends StatefulWidget {
//   const PrivateScreen({Key? key}) : super(key: key);

//   @override
//   _PrivateScreenState createState() => _PrivateScreenState();
// }

// class _PrivateScreenState extends State<PrivateScreen> {
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('http://$host:3000/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         products =
//             jsonData.map((product) => Product.fromJson(product)).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener productos')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     leading: Checkbox(
//                       activeColor: Colors.orange,
//                       value: product.selected,
//                       onChanged: (value) {
//                         setState(() {
//                           product.selected = value!;
//                         });
//                       },
//                     ),
//                     title: Text(
//                       'Nombre: ${product.name}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Categoría: ${product.category}'),
//                         Text('Precio: ${product.price.toStringAsFixed(2)}'),
//                         Text('Cantidad: ${product.quantity.toString()}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Color.fromARGB(255, 24, 152, 211),
//                           ),
//                           onPressed: () {
//                             _editProduct(product);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Color.fromARGB(255, 226, 76, 66),
//                           ),
//                           onPressed: () {
//                             _deleteProduct(product.id);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0), // Relleno de 10 pixeles
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.orange, // Color de fondo naranja
//                   shape: BoxShape.circle, // Opcional: Forma del botón
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     fetchProducts();
//                   },
//                   icon: const Icon(
//                     IconData(0xe514, fontFamily: 'MaterialIcons'),
//                     color: Colors.white, // Color del icono blanco
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0), // Relleno de 10 pixeles
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.green, // Color de fondo naranja
//                   shape: BoxShape.circle, // Opcional: Forma del botón
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     _addProduct();
//                   },
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white, // Color del icono blanco
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _addProduct() async {
//     // Implementa la lógica para agregar un producto aquí
//     // Puedes abrir un cuadro de diálogo de adición o navegar a una nueva pantalla para ingresar detalles del producto.
//     // Por ejemplo:
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const AddProductScreen(),
//       ),
//     ).then((value) {
//       setState(() {});
//     });
//     // Guarda el producto y luego actualiza la lista
//     await fetchProducts();
//   }

//   void _editProduct(Product product) {
//     // Implementar la lógica de edición del producto aquí
//   }

//   void _deleteProduct(int productId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirmar eliminación'),
//           content:
//               const Text('¿Estás seguro de que deseas eliminar este producto?'),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _performDelete(productId);
//                 fetchProducts();
//               },
//               child: const Text('Eliminar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancelar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void callFetchProducts() async {
//     fetchProducts();
//   }

//   Future<void> _performDelete(int productId) async {
//     final url = Uri.parse('http://$host:3000/products/$productId');
//     final response = await http.delete(url);

//     if (response.statusCode == 200) {
//       // El producto se eliminó con éxito, puedes realizar alguna acción adicional si es necesario
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al eliminar el producto')),
//       );
//     }
//   }
// }
