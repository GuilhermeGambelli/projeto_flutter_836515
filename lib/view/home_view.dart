import 'package:flutter/material.dart';

class Home_View extends StatelessWidget {
  const Home_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          _getResponsivePadding(context, 80),
          20,
          _getResponsivePadding(context, 80),
          20,
        ), // Adjust padding as needed
        child: Column(
          children: [
            const SizedBox(height: 150),
            _logo(),
            _botaoLogin(context),
            const Spacer(),
            _copyright(),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Image.asset(
      'assets/images/sukuna.jpg',
      height: 200,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  Widget _botaoLogin(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'Login');
      },
      child: const Text('Login'),
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

  double _getResponsivePadding(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }

  double _getResponsiveSize(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }
}
