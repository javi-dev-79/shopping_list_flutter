// import 'package:flutter/material.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   // Aquí puedes definir los campos y controladores para el formulario
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Añadir Producto'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           // Aquí puedes definir el formulario con los campos Nombre, Categoría, Precio y Cantidad
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nombre'),
//               ),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Categoría'),
//               ),
//               TextFormField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: 'Precio'),
//               ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: const InputDecoration(labelText: 'Cantidad'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Aquí puedes implementar la lógica para guardar el producto en la base de datos
//                   // Puedes utilizar los valores de los controladores (nameController, categoryController, etc.)
//                   // para crear un nuevo producto y enviarlo al servidor.
//                   Navigator.pop(
//                       context); // Cierra la pantalla de agregar producto después de guardar.
//                 },
//                 style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//                 child: const Text('Guardar Producto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// *****************************************************************************

// import 'package:flutter/material.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   // Aquí puedes definir los campos y controladores para el formulario
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Añadir Producto'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           // Aquí puedes definir el formulario con los campos Nombre, Categoría, Precio y Cantidad
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nombre'),
//               ),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Categoría'),
//               ),
//               TextFormField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: 'Precio'),
//               ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: const InputDecoration(labelText: 'Cantidad'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Aquí puedes implementar la lógica para guardar el producto en la base de datos
//                   // Puedes utilizar los valores de los controladores (nameController, categoryController, etc.)
//                   // para crear un nuevo producto y enviarlo al servidor.
//                   Navigator.pop(
//                       context); // Cierra la pantalla de agregar producto después de guardar.
//                 },
//                 style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//                 child: const Text('Guardar Producto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// *****************************************************************************

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'constants.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   Future<void> _saveProduct() async {
//     // Obtener los valores de los controladores
//     final String name = nameController.text;
//     final String category = categoryController.text;
//     final double price = double.parse(priceController.text);
//     final int quantity = int.parse(quantityController.text);

//     // Crear un mapa con los datos del producto
//     final Map<String, dynamic> newProduct = {
//       'name': name,
//       'category': category,
//       'price': price,
//       'quantity': quantity,
//     };

//     final response = await http.post(
//       Uri.parse('http://$host:3000/products'), // Reemplaza con la URL de tu servidor
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(newProduct),
//     );

//     if (response.statusCode == 201) {
//       // Producto creado con éxito
//       Navigator.pop(context);
//     } else {
//       // Error al crear el producto, muestra un mensaje de error
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al guardar el producto')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Añadir Producto'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nombre'),
//               ),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Categoría'),
//               ),
//               TextFormField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: 'Precio'),
//               ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: const InputDecoration(labelText: 'Cantidad'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProduct,
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.orange),
//                 ),
//                 child: const Text('Guardar Producto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// *****************************************************************************

// import 'package:flutter/material.dart';

// import 'product.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   // Función de validación para convertir una cadena en un número double
//   double _parseDouble(String? value) {
//     if (value == null) {
//       return 0.0; // Valor predeterminado si el valor es nulo
//     }

//     double? result;
//     try {
//       // Reemplaza comas por puntos para asegurarte de que el formato sea válido
//       value = value.replaceAll(',', '.');

//       // Intenta convertir el valor a un double
//       result = double.parse(value);

//       // Verifica si el resultado es menor que 0 y ajústalo a 0 si es necesario
//       if (result < 0.0) {
//         result = 0.0;
//       }
//     } catch (e) {
//       result = 0.0; // Valor predeterminado si la conversión falla
//     }
//     return result;
//   }

//   // Función de validación para convertir una cadena en un número entero
//   int _parseInt(String? value) {
//     if (value == null) {
//       return 0; // Valor predeterminado si el valor es nulo
//     }

//     int? result;
//     try {
//       // Reemplaza comas por puntos para asegurarte de que el formato sea válido
//       value = value.replaceAll(',', '').replaceAll('.', '');

//       // Intenta convertir el valor a un double
//       double doubleValue = double.parse(value);

//       // Convierte el double a un int
//       result = doubleValue.toInt();

//       // Verifica si el resultado es menor que 0 y ajústalo a 0 si es necesario
//       if (result < 0) {
//         result = 0;
//       }
//     } catch (e) {
//       result = 0; // Valor predeterminado si la conversión falla
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Añadir Producto'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nombre'),
//               ),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Categoría'),
//               ),
//               TextFormField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: 'Precio'),
//               ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: const InputDecoration(labelText: 'Cantidad'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Validar los campos Precio y Cantidad antes de guardar
//                   final double? price = _parseDouble(priceController.text);
//                   final int quantity = _parseInt(quantityController.text);

//                   if (price != null && quantity != null) {
//                     // Los valores son válidos, puedes guardar el producto
//                     // Usar price y quantity para crear el nuevo producto y guardarlo en la base de datos
//                     final newProduct = Product(
//                       name: nameController.text,
//                       category: categoryController.text,
//                       price: price,
//                       quantity: quantity,
//                     );

//                     // Realizar la lógica para guardar el producto en la base de datos
//                     // Luego, puedes cerrar la pantalla de agregar producto
//                     Navigator.pop(context);
//                   } else {
//                     // Mostrar un mensaje de error si los valores no son válidos
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text('Precio y Cantidad no son válidos')),
//                     );
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.orange),
//                 ),
//                 child: const Text('Guardar Producto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// *****************************************************************************

// import 'dart:convert';

// import 'constants.dart';
// // import 'product.dart';
// // import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// // import 'private_screen.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   get privateScreen => null;

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   // Aquí puedes definir los campos y controladores para el formulario
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   String? priceError;
//   String? quantityError;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Añadir Producto'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           // Aquí puedes definir el formulario con los campos Nombre, Categoría, Precio y Cantidad
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nombre'),
//               ),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Categoría'),
//               ),
//               TextFormField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: 'Precio'),
//                 validator: (value) {
//                   final parsedValue = _parseDouble(value);
//                   if (parsedValue == null) {
//                     return 'Dato incorrecto'; // Mensaje de error si no se puede analizar a double
//                   }
//                   return null; // No hay error
//                 },
//               ),
//               if (priceError != null)
//                 Text(
//                   priceError!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               TextFormField(
//                 controller: quantityController,
//                 decoration: const InputDecoration(labelText: 'Cantidad'),
//                 validator: (value) {
//                   final parsedValue = _parseInt(value);
//                   if (parsedValue == null) {
//                     return 'Dato incorrecto'; // Mensaje de error si no se puede analizar a int
//                   }
//                   return null; // No hay error
//                 },
//               ),
//               if (quantityError != null)
//                 Text(
//                   quantityError!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   final double? parsedPrice =
//                       _parseDouble(priceController.text);
//                   final int? parsedQuantity =
//                       _parseInt(quantityController.text);

//                   if (parsedPrice == null) {
//                     setState(() {
//                       priceError = 'Dato incorrecto';
//                     });
//                   } else {
//                     setState(() {
//                       priceError = null;
//                     });
//                   }

//                   if (parsedQuantity == null) {
//                     setState(() {
//                       quantityError = 'Dato incorrecto';
//                     });
//                   } else {
//                     setState(() {
//                       quantityError = null;
//                     });
//                   }

//                   if (parsedPrice != null && parsedQuantity != null) {
//                     // Aquí puedes implementar la lógica para guardar el producto en la base de datos
//                     _saveProduct(); // Llama al método _saveProduct para guardar el producto.
//                     // Puedes utilizar los valores de los controladores (nameController, categoryController, etc.)
//                     // para crear un nuevo producto y enviarlo al servidor.

//                     Navigator.pop(context,
//                         true); // Cierra la pantalla de agregar producto después de guardar.

//                     // En lugar de Navigator.pop(context), pasamos datos de vuelta a PrivateScreen
//                     // Navigator.pop(
//                     //     context, {'updateList': true, 'newProduct': Product});
//                     // Navigator.pushReplacement(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const PrivateScreen(),
//                     //   ),
//                     // );
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.orange),
//                 ),
//                 child: const Text('Guardar Producto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveProduct() async {
//     final String name = nameController.text;
//     final String category = categoryController.text;
//     final double price = _parseDouble(priceController.text)!;
//     final int quantity = _parseInt(quantityController.text)!;

//     final Map<String, dynamic> productData = {
//       "name": name,
//       "category": category,
//       "price": price,
//       "quantity": quantity,
//     };

//     final response = await http.post(
//       Uri.parse('http://$host:3000/products'), // Reemplaza con la URL correcta
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(productData),
//     );

//     if (response.statusCode == 201) {
//       // Producto guardado exitosamente
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al guardar el producto')),
//       );
//     }
//   }

//   double? _parseDouble(String? value) {
//     if (value == null) {
//       return null;
//     }

//     try {
//       value = value.replaceAll(',', '').replaceAll('.', '');
//       final result = double.parse(value);

//       if (result < 0) {
//         return null;
//       }

//       return result;
//     } catch (e) {
//       return null;
//     }
//   }

//   int? _parseInt(String? value) {
//     if (value == null) {
//       return null;
//     }

//     try {
//       value = value.replaceAll(',', '').replaceAll('.', '');
//       final result = int.parse(value);

//       if (result < 0) {
//         return null;
//       }

//       return result;
//     } catch (e) {
//       return null;
//     }
//   }
// }
