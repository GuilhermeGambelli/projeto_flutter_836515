import 'package:flutter/material.dart';

class Sobre_View extends StatelessWidget {
  const Sobre_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Sobre o desenvolvedor'), // Set the title for the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, 'Login'), // Go back on press
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image section
            Image.asset(
              'assets/images/wallpaper_sobre.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Information section
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Guilherme Sandri Gambelli'),
                  ),
                  ListTile(
                    leading: Icon(Icons.functions),
                    title: Text('Desenvolvedor Flutter'),
                  ),
                  // Código do desenvolvedor
                  ListTile(
                    leading: Icon(Icons.code),
                    title: Text('Código: 836515'),
                  ),
                  // Curso do desenvolvedor
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Curso: Engenharia da Computação'),
                  ),
                  // Links para redes sociais
                  ListTile(
                    leading: Icon(Icons.link),
                    title: Text('https://www.exemplo.com'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 270),
            _copyright(),
          ],
        ),
      ),
    );
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
}
