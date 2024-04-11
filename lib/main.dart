// ignore_for_file: unused_import

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/view/compras_view.dart';
import 'package:flutter_login/view/login_view.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_login/view/cadastro_view.dart';
import 'view/app_view.dart';
import 'view/home_view.dart';
import 'view/listas_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/usuarios_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

//
// MainApp
//
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prova Parcial',
      
      //
      // Rotas de Navegação
      //
      initialRoute: 'Home',
      routes: {
        'Home': (context) => const Home_View(),
        'Login': (context) => const Login_View(),
        'Cadastro': (context) => const Cadastro_View(),
        'Reset': (context) => const Recuperar_Senha_View(),
        'Sobre': (context) => const Sobre_View(),
        'App': (context) => const App_View(),
        'Listas': (context) => const Listas_View(),
        'Compras': (context) => const Compras_View(),
        //'Usuarios': (context) => const Usuarios_View(),
      },
    );
  }
}

var maskPhone = MaskTextInputFormatter(
    mask: '0## #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var maskCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var maskCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var maskEmail = MaskTextInputFormatter(
    mask:
        '###############################################', // Defina a máscara conforme necessário
    filter: {
      "#": RegExp(r'[a-zA-Z0-9@._-]')
    }, // Use uma expressão regular adequada para validar caracteres permitidos
    type: MaskAutoCompletionType.lazy);