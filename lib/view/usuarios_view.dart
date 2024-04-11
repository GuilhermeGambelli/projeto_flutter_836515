/*import 'package:flutter/material.dart';

class Usuarios_View extends StatefulWidget {
  const Usuarios_View({super.key});

  @override
  State<Usuarios_View> createState() => _Usuarios_ViewState();
}

class _Usuarios_ViewState extends State<Usuarios_View> {
  List<Map<String, String>> usuariosRegistrados = [];

  @override
  void initState() {
    super.initState();
    // Fetch users from storage or network (replace with your actual logic)
    fetchUsuarios();
  }

  void fetchUsuarios() {
    // Replace this with your logic to retrieve users
    // For example, fetch from a database or network
    // usuariosRegistrados = await fetchFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: ListView.builder(
        itemCount: usuariosRegistrados.length,
        itemBuilder: (context, index) {
          final usuario = usuariosRegistrados[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(usuario['nome'].substring(0, 1).toUpperCase()),
            ),
            title: Text(usuario['nome']),
            subtitle: Text(usuario['email']),
          );
        },
      ),
    );
  }
}
*/