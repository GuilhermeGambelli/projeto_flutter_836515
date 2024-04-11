// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'compras_view.dart';

class App_View extends StatefulWidget {
  const App_View({super.key});

  @override
  State<App_View> createState() => _App_ViewState();
}

class _App_ViewState extends State<App_View> {
  final List<List<Item>> _listasSalvas = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Center(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tela Inicial'),
            // ... Conteúdo da tela inicial ...
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
              context, 'Compras'); // Navigate to CriarListas screen
        },
        child: const Icon(Icons.add),
        tooltip: 'Criar Listas',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tela Inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Gerenciar Listas',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'App');
              break;
            case 1:
              Navigator.pushNamed(context, 'Listas', arguments: _listasSalvas);
              break;
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 175, 68, 247), // You can set a fixed color here
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Olá, '),
                  FutureBuilder<String>(
                    future: _getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      } else {
                        return const Text('Carregando...');
                      }
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Usuários'),
              onTap: () {
                Navigator.pushNamed(context, 'Usuarios');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Configuração'),
              onTap: () {
                Navigator.pushNamed(context, 'Configuracao');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pushNamed(context, 'Sobre');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                // Implement logout logic (clear user data, tokens etc.)
                // Navigate back to login screen
                Navigator.pushNamedAndRemoveUntil(
                    context, 'Home', (Route route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserName() async {
    // Implementar a lógica para recuperar o nome do usuário logado
    // Retornar o nome do usuário
    return 'Guilherme';
  }
}

  Widget _copyright() {
    return const Padding(
      padding: EdgeInsets.all(1.0),
      child: Text(
        '© 2024 - Projeto Gambelli',
        style: TextStyle(fontSize: 12),
      ),
    );
  }