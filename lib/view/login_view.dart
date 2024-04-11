import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Login_View extends StatefulWidget {
  const Login_View({super.key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  //Chave para o formulário
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'), // Set the title for the app bar
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
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //
                    //Icone
                    //
                    Image.asset(
                      'assets/images/rentt.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    TextFormField(
                      inputFormatters: [maskEmail],
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'SENHA',
                        hintText: '********',
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
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        //
                        // Executar o processo de VALIDAÇÃO
                        //
                        if (formKey.currentState!.validate()) {
                          //Validado com sucesso
                          Navigator.pushNamed(
                            context,
                            'App',
                          );
                        } else {
                          //Erro na validação
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
                height: 110), // Ajuste o espaçamento conforme necessário
            OutlinedButton(
              onPressed: () {
                //
                // Executar o processo de VALIDAÇÃO
                //
                Navigator.pushNamed(
                  context,
                  'Cadastro',
                );
              },
              child: const Text(
                'Criar Conta',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                //
                // Executar o processo de VALIDAÇÃO
                //
                Navigator.pushNamed(
                  context,
                  'Reset',
                );
              },
              child: const Text(
                'Recuperar Senha',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 10),
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

  double _getResponsivePadding(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }

  double _getResponsiveSize(BuildContext context, double defaultValue) {
    return MediaQuery.of(context).size.width * (defaultValue / 375);
  }
}
