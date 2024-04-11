import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../main.dart';

//
// PrincipalView
//
class Recuperar_Senha_View extends StatefulWidget {
  const Recuperar_Senha_View({super.key});

  @override
  State<Recuperar_Senha_View> createState() => _Recuperar_Senha_ViewState();
}

class _Recuperar_Senha_ViewState extends State<Recuperar_Senha_View> {
  //Chave para o formulário
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'), // Set the title for the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            'Login'
            ), // Go back on press
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
          key: formKey,
          child: Column(
            children: [
              //
              //Icone
              //
              Icon(
                Icons.how_to_reg,
                size: 120,
                color: Colors.blue.shade900,
              ),
              const SizedBox(height: 30),
              TextFormField(
                inputFormatters: [maskEmail],
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
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  labelText: 'NOVA SENHA',
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
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  //
                  // Executar o processo de VALIDAÇÃO
                  //
                  if (formKey.currentState!.validate()) {
                    //Validado com sucesso
                    Navigator.pushNamed(
                      context,
                      'Login',
                    );
                  } else {
                    //Erro na validação
                  }
                },
                child: const Text(
                  'Recuperar',
                  style: const TextStyle(fontSize: 30),
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
