import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

//
// PrincipalView
//
class Cadastro_View extends StatefulWidget {
  const Cadastro_View({super.key});

  @override
  State<Cadastro_View> createState() => _Cadastro_ViewState();
}

class _Cadastro_ViewState extends State<Cadastro_View> {
  // Chaves para os formulários
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<Map<String, String>> usuariosRegistrados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'), // Set the title for the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, 'Home'), // Go back on press
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          _getResponsivePadding(context, 50),
          20,
          _getResponsivePadding(context, 50),
          20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //
              //Icone
              //
              Icon(
                Icons.how_to_reg,
                size: 70,
                color: Colors.blue.shade900,
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CÓDIGO',
                  hintText: '123456',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Infome um valor';
                  } else if (value.isEmpty) {
                    return 'Infome um valor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'NOME',
                  hintText: 'João da Silva Sauro',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Infome um valor';
                  } else if (value.isEmpty) {
                    return 'Infome um valor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-MAIL',
                  hintText: 'exemplo@exemplo.com',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Informe um valor';
                  } else if (value.isEmpty) {
                    return 'Informe um valor';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // Hide password characters
                decoration: const InputDecoration(
                  labelText: 'SENHA',
                  hintText: '********',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Informe um valor';
                  } else if (value.isEmpty) {
                    return 'Informe um valor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // Hide password characters
                decoration: const InputDecoration(
                  labelText: 'CONFIRMAR SENHA',
                  hintText: '********',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Informe um valor';
                  } else if (value.isEmpty) {
                    return 'Informe um valor';
                  } else if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                      usuariosRegistrados.add({
                        'codigo': codigoController.text,
                        'nome': nomeController.text,
                        'email': emailController.text,
                        'senha': _passwordController.text,
                      });
                    Navigator.pushNamed(
                      context, 
                      'Login'
                      );
                  }
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const Spacer(),
              _copyright(),
            ],
          ),
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

  double _getResponsivePadding(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }

  double _getResponsiveSize(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }
}
