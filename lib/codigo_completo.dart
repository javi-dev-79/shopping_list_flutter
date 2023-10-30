// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'constants.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         unselectedWidgetColor:
//             Colors.orange, // Color del checkbox no seleccionado
//         // Otros ajustes de estilo que desees aplicar a toda la aplicación
//       ),
//       home: const MyApp(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyBottomNavigationBar(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

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

// class MyBottomNavigationBar extends StatefulWidget {
//   const MyBottomNavigationBar({super.key});

//   @override
//   _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   int _selectedIndex = 0; // Índice de la página seleccionada
//   bool loggedIn = false; // Estado de inicio de sesión

//   @override
//   void initState() {
//     super.initState();
//     // Inicializa el estado de inicio de sesión como falso
//     loggedIn = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget body;

//     if (_selectedIndex == 0) {
//       body = const PublicScreen();
//     } else {
//       body = loggedIn ? const PrivateScreen() : const PublicScreen();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mi Aplicación'),
//         backgroundColor: Colors.orange,
//         actions: <Widget>[
//           if (!loggedIn)
//             IconButton(
//               icon: const Icon(Icons.login),
//               onPressed: _handleLoginButton,
//             ),
//           if (loggedIn)
//             IconButton(
//               icon: const Icon(Icons.logout),
//               onPressed:
//                   _handleLogoutButton, // Agregamos el manejador de cierre de sesión
//             ),
//         ],
//       ),
//       body: body,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.public),
//             label: 'Pública',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.lock),
//             label: 'Privada',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       if (index == 1 && !loggedIn) {
//         // El usuario selecciona "Privada" pero no está logueado
//         Navigator.of(context)
//             .push(
//           MaterialPageRoute(
//             builder: (context) => LoginScreen(),
//           ),
//         )
//             .then((result) {
//           if (result == true) {
//             setState(() {
//               loggedIn = true;
//               _selectedIndex = 1; // Cambia a la pantalla "Privada"
//             });
//           }
//         });
//       } else {
//         _selectedIndex = index;
//       }
//     });
//   }

//   void _handleLoginButton() {
//     Navigator.of(context)
//         .push(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//     )
//         .then((result) {
//       if (result == true) {
//         setState(() {
//           loggedIn = true;
//           if (loggedIn) {
//             _selectedIndex = 1; // Cambia a la pantalla "Privada"
//           }
//         });
//       }
//     });
//   }

//   void _handleLogoutButton() {
//     // Realiza la lógica de cierre de sesión (cambia el estado de loggedIn, redirige, etc.)
//     // Luego, muestra un SnackBar con el mensaje de confirmación.

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Has cerrado sesión, hasta luego...'),
//       ),
//     );

//     // Después de cerrar sesión, establece loggedIn como false y el índice seleccionado según tu lógica.
//     setState(() {
//       loggedIn = false;
//       _selectedIndex =
//           0; // Cambia a la pantalla "Pública" u otra pantalla inicial
//     });
//   }
// }

// class UserListScreen extends StatefulWidget {
//   const UserListScreen({Key? key}) : super(key: key);

//   @override
//   _UserListScreenState createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   List<User> users = [];
//   List<bool> selectedUsers = [];

//   final Logger logger = Logger();

//   @override
//   void initState() {
//     super.initState();
//     // Inicializa la lista de usuarios con datos de users.json
//     fetchUsers();
//   }

//   Future<void> fetchUsers() async {
//     final response = await http.get(Uri.parse(
//         'http://$host:3000/users')); // Reemplaza con la URL de tu servidor JSON

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         users = jsonData.map((user) => User.fromJson(user)).toList();
//         selectedUsers = List.generate(users.length, (index) => false);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener usuarios')),
//       );
//     }
//   }

//   Future<void> eliminarUsuarioDelArchivo(int userId) async {
//     final file = File('users.json');
//     final content = await file.readAsString();
//     final usuarios = jsonDecode(content);

//     // Encuentra y elimina el usuario del archivo
//     usuarios.removeWhere((usuario) => usuario['id'] == userId);

//     // Escribe los usuarios actualizados en el archivo
//     await file.writeAsString(jsonEncode(usuarios));
//   }

//   Future<void> eliminarUsuariosEnServidor(List<int> usuariosAEliminar) async {
//     for (int userId in usuariosAEliminar) {
//       final url = Uri.parse(
//           'http://$host:3000/users/$userId'); // URL para eliminar el usuario por ID
//       final response = await http.delete(url);

//       if (response.statusCode == 204) {
//         logger.d('Usuario con ID $userId eliminado con éxito');
//       } else {
//         logger.e(
//             'Error al eliminar el usuario con ID $userId. Código de estado: ${response.statusCode}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de Usuarios'),
//         backgroundColor: Colors.orange,
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             leading: Checkbox(
//               activeColor: Colors.orange,
//               value: selectedUsers[index],
//               onChanged: (value) {
//                 setState(() {
//                   selectedUsers[index] = value!;
//                 });
//               },
//             ),
//             title: Text(
//                 'ID: ${user.id}, Usuario: ${user.name}, Email: ${user.email}'),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: ElevatedButton(
//           onPressed: () {
//             List<int> usuariosAEliminar = [];

//             for (int i = 0; i < selectedUsers.length; i++) {
//               if (selectedUsers[i]) {
//                 usuariosAEliminar.add(users[i].id);
//               }
//             }

//             eliminarUsuariosEnServidor(usuariosAEliminar);

//             // Elimina usuarios seleccionados de la lista
//             for (int i = usuariosAEliminar.length - 1; i >= 0; i--) {
//               final userId = usuariosAEliminar[i];
//               users.removeWhere((user) => user.id == userId);
//               selectedUsers.removeAt(i);
//             }

//             // Establece todos los elementos en selectedUsers en false
//             selectedUsers = List.generate(users.length, (index) => false);

//             setState(() {});
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange,
//           ),
//           child: const Text(
//             'Eliminar',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _usuarioTextEditingController =
//       TextEditingController();
//   final TextEditingController _emailTextEditingController =
//       TextEditingController();
//   final Color _cursorColor = Colors.blueGrey;
//   final FocusNode _usuarioFocusNode = FocusNode();

//   LoginScreen({Key? key}) : super(key: key);

//   Future<http.Response> fetchUsers() async {
//     final url = Uri.parse('http://$host:3000/users'); // Reemplaza con tu URL
//     final response = await http.get(url);
//     return response;
//   }

//   Future<void> _performLogin(BuildContext context) async {
//     final usuario = _usuarioTextEditingController.text;
//     final email = _emailTextEditingController.text;

//     final response = await fetchUsers();
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       bool credentialsMatch = false;

//       for (var userData in jsonData) {
//         final String name = userData['name'];
//         final String userEmail = userData['email'];

//         if (name == usuario && userEmail == email) {
//           credentialsMatch = true;
//           break;
//         }
//       }

//       if (credentialsMatch) {
//         // Navigator.pop(context, true);
//         Navigator.of(context).pop(
//             true); // Esto regresará a la pantalla anterior, que es la privada
//       } else {
//         _showErrorMessage(context);
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener usuarios')),
//       );
//     }
//   }

//   void _showErrorMessage(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Usuario desconocido'),
//           content: const Text('Las credenciales ingresadas no son válidas.'),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.orange, // Color del texto del botón
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Aceptar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inicio de Sesión'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usuarioTextEditingController,
//               cursorColor: _cursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Usuario',
//                 labelStyle: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//               // focusNode: _usuarioFocusNode,
//               autofocus:
//                   true, // Esta línea coloca el cursor por defecto en el campo "Usuario"
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailTextEditingController,
//               cursorColor: _cursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _performLogin(context);
//                 _usuarioTextEditingController.clear(); // Borra el campo Usuario
//                 _emailTextEditingController.clear(); // Borra el campo Email

//                 // Enfoca nuevamente el campo 'Usuario'
//                 _usuarioFocusNode.requestFocus();
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: const Text('Iniciar Sesión'),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => RegistrationScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Registrarse',
//                 style: TextStyle(
//                   color: Colors.orange,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
//                           // product.selected = value!;
//                           product.setSelected(value!);
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

// class Product {
//   final int id;
//   final String name;
//   final String category;
//   final double price;
//   int quantity;
//   bool selected;

//   Product({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.price,
//     this.quantity = 0,
//     this.selected = false,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//       price: json['price'].toDouble(),
//       quantity: json['quantity'],
//       selected: false, // Establecer como no seleccionado por defecto
//     );
//   }

//   void setSelected(bool value) {
//     selected = value;
//   }
// }

// class PublicScreen extends StatelessWidget {
//   const PublicScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Contenido de la Página Pública'),
//       ),
//     );
//   }
// }

// final Logger logger = Logger();

// class RegistrationScreen extends StatelessWidget {
//   final TextEditingController _registrationTextEditingController =
//       TextEditingController();

//   final TextEditingController _registrationEmailEditingController =
//       TextEditingController();

//   final Color _registrationCursorColor = Colors.orange;

//   final FocusNode _usuarioFocusNode = FocusNode();

//   RegistrationScreen({Key? key}) : super(key: key);

//   Future<http.Response> registerUser(String name, String email) async {
//     // final url = Uri.parse(
//     //     'http://$host:3000/users'); // Reemplaza con la URL de tu servidor JSON
//     final url =
//         Uri.parse('http://$host:3000/users'); // Actualiza la URL a "db.json"

//     final response = await http.post(url, body: {
//       'name': name,
//       'email': email,
//     });

//     return response;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registro'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _registrationTextEditingController,
//               cursorColor: _registrationCursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Usuario',
//                 labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.orange),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//               autofocus:
//                   true, // Esta línea coloca el cursor por defecto en el campo "Usuario"
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _registrationEmailEditingController,
//               cursorColor: _registrationCursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.orange),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final name = _registrationTextEditingController.text;
//                 final email = _registrationEmailEditingController.text;

//                 final response = await registerUser(name, email);

//                 if (response.statusCode == 201) {
//                   logger.d('Usuario registrado con éxito');
//                   // Navegar de nuevo a la pantalla de inicio de sesión después de un registro exitoso
//                   // Navigator.of(context).push(
//                   //   MaterialPageRoute(
//                   //     builder: (context) => LoginScreen(),
//                   //   ),
//                   // );
//                 } else {
//                   logger.e(
//                       'Error al registrar el usuario. Código de estado: ${response.statusCode}');
//                 }
//                 // Borra los campos TextField
//                 _registrationTextEditingController.clear();
//                 _registrationEmailEditingController.clear();

//                 // Enfoca nuevamente el campo 'Usuario'
//                 _usuarioFocusNode.requestFocus();
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: const Text('Registrarse'),
//             ),
//             const SizedBox(
//                 height:
//                     10), // Espacio entre el botón "Registrarse" y el enlace "Eliminar"
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const UserListScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Eliminar',
//                 style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String email;

//   User({required this.id, required this.name, required this.email});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
// }


// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************


// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'constants.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         unselectedWidgetColor:
//             Colors.orange, // Color del checkbox no seleccionado
//         // Otros ajustes de estilo que desees aplicar a toda la aplicación
//       ),
//       home: const MyApp(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyBottomNavigationBar(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

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
//                   final parsedValue = Utils._parseDouble(value);
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
//                   final parsedValue = Utils._parseInt(value);
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
//                       Utils._parseDouble(priceController.text);
//                   final int? parsedQuantity =
//                       Utils._parseInt(quantityController.text);

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
//     final double price = Utils._parseDouble(priceController.text)!;
//     final int quantity = Utils._parseInt(quantityController.text)!;

//     final Map<String, dynamic> productData = {
//       "name": name,
//       "category": category,
//       "price": price,
//       "quantity": quantity,
//       "selected": false, // Agregar "selected" con valor predeterminado false
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
// }

// class MyBottomNavigationBar extends StatefulWidget {
//   const MyBottomNavigationBar({super.key});

//   @override
//   _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   int _selectedIndex = 0; // Índice de la página seleccionada
//   bool loggedIn = false; // Estado de inicio de sesión

//   @override
//   void initState() {
//     super.initState();
//     // Inicializa el estado de inicio de sesión como falso
//     loggedIn = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget body;

//     if (_selectedIndex == 0) {
//       body = const PublicScreen();
//     } else {
//       body = loggedIn ? const PrivateScreen() : const PublicScreen();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mi Aplicación'),
//         backgroundColor: Colors.orange,
//         actions: <Widget>[
//           if (!loggedIn)
//             IconButton(
//               icon: const Icon(Icons.login),
//               onPressed: _handleLoginButton,
//             ),
//           if (loggedIn)
//             IconButton(
//               icon: const Icon(Icons.logout),
//               onPressed:
//                   _handleLogoutButton, // Agregamos el manejador de cierre de sesión
//             ),
//         ],
//       ),
//       body: body,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.public),
//             label: 'Pública',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.lock),
//             label: 'Privada',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       if (index == 1 && !loggedIn) {
//         // El usuario selecciona "Privada" pero no está logueado
//         Navigator.of(context)
//             .push(
//           MaterialPageRoute(
//             builder: (context) => LoginScreen(),
//           ),
//         )
//             .then((result) {
//           if (result == true) {
//             setState(() {
//               loggedIn = true;
//               _selectedIndex = 1; // Cambia a la pantalla "Privada"
//             });
//           }
//         });
//       } else {
//         _selectedIndex = index;
//       }
//     });
//   }

//   void _handleLoginButton() {
//     Navigator.of(context)
//         .push(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//     )
//         .then((result) {
//       if (result == true) {
//         setState(() {
//           loggedIn = true;
//           if (loggedIn) {
//             _selectedIndex = 1; // Cambia a la pantalla "Privada"
//           }
//         });
//       }
//     });
//   }

//   void _handleLogoutButton() {
//     // Realiza la lógica de cierre de sesión (cambia el estado de loggedIn, redirige, etc.)
//     // Luego, muestra un SnackBar con el mensaje de confirmación.

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Has cerrado sesión, hasta luego...'),
//       ),
//     );

//     // Después de cerrar sesión, establece loggedIn como false y el índice seleccionado según tu lógica.
//     setState(() {
//       loggedIn = false;
//       _selectedIndex =
//           0; // Cambia a la pantalla "Pública" u otra pantalla inicial
//     });
//   }
// }

// class UserListScreen extends StatefulWidget {
//   const UserListScreen({Key? key}) : super(key: key);

//   @override
//   _UserListScreenState createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   List<User> users = [];
//   List<bool> selectedUsers = [];

//   final Logger logger = Logger();

//   @override
//   void initState() {
//     super.initState();
//     // Inicializa la lista de usuarios con datos de users.json
//     fetchUsers();
//   }

//   Future<void> fetchUsers() async {
//     final response = await http.get(Uri.parse(
//         'http://$host:3000/users')); // Reemplaza con la URL de tu servidor JSON

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         users = jsonData.map((user) => User.fromJson(user)).toList();
//         selectedUsers = List.generate(users.length, (index) => false);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener usuarios')),
//       );
//     }
//   }

//   Future<void> eliminarUsuarioDelArchivo(int userId) async {
//     final file = File('users.json');
//     final content = await file.readAsString();
//     final usuarios = jsonDecode(content);

//     // Encuentra y elimina el usuario del archivo
//     usuarios.removeWhere((usuario) => usuario['id'] == userId);

//     // Escribe los usuarios actualizados en el archivo
//     await file.writeAsString(jsonEncode(usuarios));
//   }

//   Future<void> eliminarUsuariosEnServidor(List<int> usuariosAEliminar) async {
//     for (int userId in usuariosAEliminar) {
//       final url = Uri.parse(
//           'http://$host:3000/users/$userId'); // URL para eliminar el usuario por ID
//       final response = await http.delete(url);

//       if (response.statusCode == 204) {
//         logger.d('Usuario con ID $userId eliminado con éxito');
//       } else {
//         logger.e(
//             'Error al eliminar el usuario con ID $userId. Código de estado: ${response.statusCode}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de Usuarios'),
//         backgroundColor: Colors.orange,
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             leading: Checkbox(
//               activeColor: Colors.orange,
//               value: selectedUsers[index],
//               onChanged: (value) {
//                 setState(() {
//                   selectedUsers[index] = value!;
//                 });
//               },
//             ),
//             title: Text(
//                 'ID: ${user.id}, Usuario: ${user.name}, Email: ${user.email}'),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: ElevatedButton(
//           onPressed: () {
//             List<int> usuariosAEliminar = [];

//             for (int i = 0; i < selectedUsers.length; i++) {
//               if (selectedUsers[i]) {
//                 usuariosAEliminar.add(users[i].id);
//               }
//             }

//             eliminarUsuariosEnServidor(usuariosAEliminar);

//             // Elimina usuarios seleccionados de la lista
//             for (int i = usuariosAEliminar.length - 1; i >= 0; i--) {
//               final userId = usuariosAEliminar[i];
//               users.removeWhere((user) => user.id == userId);
//               selectedUsers.removeAt(i);
//             }

//             // Establece todos los elementos en selectedUsers en false
//             selectedUsers = List.generate(users.length, (index) => false);

//             setState(() {});
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange,
//           ),
//           child: const Text(
//             'Eliminar',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _usuarioTextEditingController =
//       TextEditingController();
//   final TextEditingController _emailTextEditingController =
//       TextEditingController();
//   final Color _cursorColor = Colors.blueGrey;
//   final FocusNode _usuarioFocusNode = FocusNode();

//   LoginScreen({Key? key}) : super(key: key);

//   Future<http.Response> fetchUsers() async {
//     final url = Uri.parse('http://$host:3000/users'); // Reemplaza con tu URL
//     final response = await http.get(url);
//     return response;
//   }

//   Future<void> _performLogin(BuildContext context) async {
//     final usuario = _usuarioTextEditingController.text;
//     final email = _emailTextEditingController.text;

//     final response = await fetchUsers();
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       bool credentialsMatch = false;

//       for (var userData in jsonData) {
//         final String name = userData['name'];
//         final String userEmail = userData['email'];

//         if (name == usuario && userEmail == email) {
//           credentialsMatch = true;
//           break;
//         }
//       }

//       if (credentialsMatch) {
//         // Navigator.pop(context, true);
//         Navigator.of(context).pop(
//             true); // Esto regresará a la pantalla anterior, que es la privada
//       } else {
//         _showErrorMessage(context);
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error al obtener usuarios')),
//       );
//     }
//   }

//   void _showErrorMessage(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Usuario desconocido'),
//           content: const Text('Las credenciales ingresadas no son válidas.'),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.orange, // Color del texto del botón
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Aceptar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inicio de Sesión'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usuarioTextEditingController,
//               cursorColor: _cursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Usuario',
//                 labelStyle: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//               // focusNode: _usuarioFocusNode,
//               autofocus:
//                   true, // Esta línea coloca el cursor por defecto en el campo "Usuario"
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailTextEditingController,
//               cursorColor: _cursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _performLogin(context);
//                 _usuarioTextEditingController.clear(); // Borra el campo Usuario
//                 _emailTextEditingController.clear(); // Borra el campo Email

//                 // Enfoca nuevamente el campo 'Usuario'
//                 _usuarioFocusNode.requestFocus();
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: const Text('Iniciar Sesión'),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => RegistrationScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Registrarse',
//                 style: TextStyle(
//                   color: Colors.orange,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
//         products = jsonData.map((product) {
//           // Actualiza el estado 'selected' al recibir el producto
//           return Product.fromJson(product);
//         }).toList();
//       });

//       // Registra los productos en el logger
//       for (final product in products) {
//         logger.d(
//             'Producto: ${product.name}, Categoría: ${product.category}, Precio: ${product.price}, Cantidad: ${product.quantity}, Selected: ${product.selected}');
//       }
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
//                       value: product
//                           .selected, // Asigna el valor de 'selected' al Checkbox
//                       onChanged: (value) async {
//                         setState(() {
//                           product.selected = value!;
//                           _updateProduct(
//                               product); // Aquí debes implementar la lógica para actualizar en el servidor
//                         });

//                         // Realiza una solicitud HTTP POST para actualizar el estado "selected" en el servidor
//                         final url = Uri.parse(
//                             'http://$host:3000/products/${product.id}');
//                         final response = await http.post(
//                           url,
//                           headers: {"Content-Type": "application/json"},
//                           body: jsonEncode({"selected": product.selected}),
//                         );

//                         if (response.statusCode != 200) {
//                           // Ocurrió un error, puedes manejarlo aquí
//                           setState(() {
//                             // Revierte el cambio local en caso de error
//                             product.selected = value!;
//                           });
//                         }
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
//                         Text('Precio: ${product.price.toStringAsFixed(2)}€'),
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
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.orange,
//                   shape: BoxShape.circle,
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     fetchProducts();
//                   },
//                   icon: const Icon(
//                     IconData(0xe514, fontFamily: 'MaterialIcons'),
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     _addProduct();
//                   },
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _updateProduct(Product product) async {
//     // Create a Map with the updated product data, setting 'selected' to the new value.
//     final updatedProductData = {
//       'id': product.id,
//       'name': product.name,
//       'category': product.category,
//       'price': product.price,
//       'quantity': product.quantity,
//       'selected': product.selected, // Set the 'selected' value.
//     };

//     final url = Uri.parse('http://$host:3000/products/${product.id}');
//     final response = await http.put(
//       url,
//       body: json.encode(updatedProductData),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       // Product was updated successfully.
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error updating the product')),
//       );
//     }
//   }

//   Future<void> _addProduct() async {
//     // Implementa la lógica para agregar un producto
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
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProductScreen(product: product),
//       ),
//     ).then((updatedProduct) {
//       if (updatedProduct != null) {
//         // Actualiza el producto en la lista o realiza cualquier acción necesaria
//         // Puedes hacer esto en base a los datos de updatedProduct
//         setState(() {
//           // Busca el producto en la lista y actualiza sus datos
//           final index = products.indexWhere((p) => p.id == updatedProduct.id);
//           if (index != -1) {
//             products[index] = updatedProduct;
//           }
//         });
//       }
//     });
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

// class Product {
//   final int id;
//   final String name;
//   final String category;
//   final double price;
//   final int quantity;
//   bool selected;

//   Product({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.price,
//     this.quantity = 0,
//     this.selected = false,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//         id: json['id'],
//         name: json['name'],
//         category: json['category'],
//         price: json['price'].toDouble(),
//         quantity: json['quantity'],
//         selected: json['selected']);
//   }

//   void setSelected(bool value) {
//     selected = value;
//   }
// }

// class PublicScreen extends StatefulWidget {
//   const PublicScreen({Key? key}) : super(key: key);

//   @override
//   _PublicScreenState createState() => _PublicScreenState();
// }

// class _PublicScreenState extends State<PublicScreen> {
//   List<Product> selectedProducts = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSelectedProducts();
//   }

//   Future<void> fetchSelectedProducts() async {
//     final response = await http.get(Uri.parse('http://$host:3000/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       final products =
//           jsonData.map((product) => Product.fromJson(product)).toList();

//       setState(() {
//         selectedProducts =
//             products.where((product) => product.selected).toList();
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
//       body: selectedProducts.isEmpty
//           ? const Center(child: Text('No hay productos seleccionados'))
//           : Padding(
//               padding: const EdgeInsets.all(
//                   10.0), // Agregar un padding de 10 píxeles
//               child: ListView.builder(
//                 itemCount: selectedProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = selectedProducts[index];
//                   return ListTile(
//                     title: Text(
//                       'Nombre: ${product.name}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight
//                             .bold, // Mostrar el campo "nombre" en negrita
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Categoría: ${product.category}'),
//                         Text(
//                             'Precio: ${product.price.toStringAsFixed(2)} €'), // Agregar el símbolo €
//                         Text('Cantidad: ${product.quantity.toString()}'),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

// final Logger logger = Logger();

// class RegistrationScreen extends StatelessWidget {
//   final TextEditingController _registrationTextEditingController =
//       TextEditingController();

//   final TextEditingController _registrationEmailEditingController =
//       TextEditingController();

//   final Color _registrationCursorColor = Colors.orange;

//   final FocusNode _usuarioFocusNode = FocusNode();

//   RegistrationScreen({Key? key}) : super(key: key);

//   Future<http.Response> registerUser(String name, String email) async {
//     // final url = Uri.parse(
//     //     'http://$host:3000/users'); // Reemplaza con la URL de tu servidor JSON
//     final url =
//         Uri.parse('http://$host:3000/users'); // Actualiza la URL a "db.json"

//     final response = await http.post(url, body: {
//       'name': name,
//       'email': email,
//     });

//     return response;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registro'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _registrationTextEditingController,
//               cursorColor: _registrationCursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Usuario',
//                 labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.orange),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//               autofocus:
//                   true, // Esta línea coloca el cursor por defecto en el campo "Usuario"
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _registrationEmailEditingController,
//               cursorColor: _registrationCursorColor,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.orange),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final name = _registrationTextEditingController.text;
//                 final email = _registrationEmailEditingController.text;

//                 final response = await registerUser(name, email);

//                 if (response.statusCode == 201) {
//                   logger.d('Usuario registrado con éxito');
//                   // Navegar de nuevo a la pantalla de inicio de sesión después de un registro exitoso
//                   // Navigator.of(context).push(
//                   //   MaterialPageRoute(
//                   //     builder: (context) => LoginScreen(),
//                   //   ),
//                   // );
//                 } else {
//                   logger.e(
//                       'Error al registrar el usuario. Código de estado: ${response.statusCode}');
//                 }
//                 // Borra los campos TextField
//                 _registrationTextEditingController.clear();
//                 _registrationEmailEditingController.clear();

//                 // Enfoca nuevamente el campo 'Usuario'
//                 _usuarioFocusNode.requestFocus();
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: const Text('Registrarse'),
//             ),
//             const SizedBox(
//                 height:
//                     10), // Espacio entre el botón "Registrarse" y el enlace "Eliminar"
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const UserListScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Eliminar',
//                 style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String email;

//   User({required this.id, required this.name, required this.email});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
// }

// // class EditProductScreen extends StatefulWidget {
// //   final Product product;

// //   const EditProductScreen({Key? key, required this.product}) : super(key: key);

// //   @override
// //   _EditProductScreenState createState() => _EditProductScreenState();
// // }

// // class _EditProductScreenState extends State<EditProductScreen> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _categoryController = TextEditingController();
// //   final TextEditingController _priceController = TextEditingController();
// //   final TextEditingController _quantityController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Editar Producto'),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Nombre',
// //               ),
// //             ),
// //             TextField(
// //               controller: _categoryController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Categoría',
// //               ),
// //             ),
// //             TextField(
// //               controller: _priceController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Precio',
// //               ),
// //             ),
// //             TextField(
// //               controller: _quantityController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Cantidad',
// //               ),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 final String name = _nameController.text;
// //                 final String category = _categoryController.text;
// //                 final double price =
// //                     Utils._parseDouble(_priceController.text) ?? 0.0;
// //                 final int quantity =
// //                     Utils._parseInt(_quantityController.text) ?? 0;

// //                 if (name.isNotEmpty &&
// //                     category.isNotEmpty &&
// //                     price >= 0 &&
// //                     quantity >= 0) {
// //                   // Los datos son válidos, guarda el producto o realiza otras acciones
// //                 } else {
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(
// //                       content: Text(
// //                           'Por favor, completa todos los campos correctamente.'),
// //                     ),
// //                   );
// //                 }
// //               },
// //               style: ButtonStyle(
// //                 backgroundColor: MaterialStateProperty.all(Colors.orange),
// //               ),
// //               child: const Text('Guardar Cambios'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// class EditProductScreen extends StatefulWidget {
//   final Product product;

//   EditProductScreen({required this.product});

//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Inicializa los controladores con los valores actuales del producto
//     nameController.text = widget.product.name;
//     categoryController.text = widget.product.category;
//     priceController.text = widget.product.price.toStringAsFixed(2);
//     quantityController.text = widget.product.quantity.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar Producto'),
//         backgroundColor: Colors.orange, // Color de la barra de navegación
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Nombre'),
//             ),
//             TextField(
//               controller: categoryController,
//               decoration: const InputDecoration(labelText: 'Categoría'),
//             ),
//             TextField(
//               controller: priceController,
//               decoration: const InputDecoration(
//                   labelText: 'Precio (€)'), // Añadido símbolo del euro
//             ),
//             TextField(
//               controller: quantityController,
//               decoration: const InputDecoration(labelText: 'Cantidad'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Obtén los valores de los controladores y realiza la validación
//                 final String name = nameController.text;
//                 final String category = categoryController.text;
//                 final double price =
//                     Utils._parseDouble(priceController.text) ?? 0.0;
//                 final int quantity =
//                     Utils._parseInt(quantityController.text) ?? 0;

//                 // Verifica que los valores sean válidos antes de guardar
//                 if (name.isNotEmpty &&
//                     category.isNotEmpty &&
//                     price >= 0 &&
//                     quantity >= 0) {
//                   // Aquí puedes realizar la actualización del producto en db.json
//                   // Utiliza el widget.product.id para identificar el producto
//                   // y los nuevos valores para actualizarlo
//                 } else {
//                   // Muestra un mensaje de error si los datos no son válidos
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text(
//                             'Por favor, completa los campos correctamente.')),
//                   );
//                 }
//               },
//               child: const Text('Guardar Cambios'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// // class EditProductScreen extends StatefulWidget {
// //   final Product product;

// //   const EditProductScreen({Key? key, required this.product}) : super(key: key);

// //   @override
// //   _EditProductScreenState createState() => _EditProductScreenState();
// // }

// // class _EditProductScreenState extends State<EditProductScreen> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _categoryController = TextEditingController();
// //   final TextEditingController _priceController = TextEditingController();
// //   final TextEditingController _quantityController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Llena los controladores de texto con los datos del producto actual
// //     _nameController.text = widget.product.name;
// //     _categoryController.text = widget.product.category;
// //     _priceController.text = widget.product.price.toStringAsFixed(2);
// //     _quantityController.text = widget.product.quantity.toString();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Editar Producto'),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Nombre',
// //                 labelStyle: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.orange,
// //                 ),
// //                 focusedBorder: UnderlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.orange),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             TextField(
// //               controller: _categoryController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Categoría',
// //                 labelStyle: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.orange,
// //                 ),
// //                 focusedBorder: UnderlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.orange),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             TextField(
// //               controller: _priceController,
// //               keyboardType: TextInputType.number,
// //               decoration: const InputDecoration(
// //                 labelText: 'Precio',
// //                 labelStyle: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.orange,
// //                 ),
// //                 focusedBorder: UnderlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.orange),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             TextField(
// //               controller: _quantityController,
// //               keyboardType: TextInputType.number,
// //               decoration: const InputDecoration(
// //                 labelText: 'Cantidad',
// //                 labelStyle: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.orange,
// //                 ),
// //                 focusedBorder: UnderlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.orange),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 // Obtén los valores editados del formulario
// //                 final String name = _nameController.text;
// //                 final String category = _categoryController.text;
// //                 final double price = double.parse(_priceController.text);
// //                 final int quantity = int.parse(_quantityController.text);

// //                 // Crea un nuevo producto con los valores editados
// //                 final updatedProduct = Product(
// //                   id: widget.product.id,
// //                   name: name,
// //                   category: category,
// //                   price: price,
// //                   quantity: quantity,
// //                   selected: widget.product.selected,
// //                 );

// //                 // Actualiza el producto en la lista local
// //                 updateProductInList(updatedProduct);

// //                 // Cierra la pantalla de edición y devuelve el producto actualizado
// //                 Navigator.pop(context, updatedProduct);
// //               },
// //               style: ButtonStyle(
// //                 backgroundColor: MaterialStateProperty.all(Colors.orange),
// //               ),
// //               child: const Text('Guardar Cambios'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

//   Future<http.Response> updateProductInList(Product product) async {
//     final url = Uri.parse('http://$host:3000/products/${product.id}');

//     final response = await http.put(url, body: {
//       'name': product.name,
//       'category': product.category,
//       'price': product.price.toString(),
//       'quantity': product.quantity.toString(),
//       'selected': product.selected.toString(),
//     });

//     return response;
//   }
// }

// class Utils {
//   static double? _parseDouble(String? value) {
//     if (value == null) {
//       return 0;
//     }

//     try {
//       value = value.replaceAll(',', '.');
//       final result = double.parse(value);

//       if (result < 0) {
//         return 0;
//       }

//       // return result;
//       // Redondear a dos decimales
//       return double.parse(result.toStringAsFixed(2));
//     } catch (e) {
//       return 0;
//     }
//   }

//   static int? _parseInt(String? value) {
//     if (value == null) {
//       return 0;
//     }

//     final List<String> parts =
//         value.split(RegExp(r'[,.]')); // Dividir por comas y puntos
//     final String firstPart = parts.first;

//     // Intenta analizar el primer valor como un número entero
//     try {
//       return int.parse(firstPart);
//     } catch (e) {
//       return 0; // En caso de error, devuelve 0 o cualquier valor por defecto que desees
//     }
//   }
// }
