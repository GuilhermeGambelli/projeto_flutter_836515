// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'compras_view.dart';

class Listas_View extends StatefulWidget {
  const Listas_View({super.key});

  @override
  State<Listas_View> createState() => _Listas_ViewState();
}

Future<List<Lista>> _carregarListas() async {
  final prefs = await SharedPreferences.getInstance();
  final listaIds = prefs.getKeys().where((key) => key.startsWith('lista_'));
  final listas = await Future.wait(listaIds.map((id) async {
    final jsonLista = await prefs.getString(id);
    return Lista.fromJson(jsonDecode(jsonLista!));
  }));
  return listas;
}

class _Listas_ViewState extends State<Listas_View> {
  List<Lista> _listasSalvas = [];
  String _searchText = "";
  bool _showSearchField = false;

  @override
  void initState() {
    super.initState();
    _carregarListas().then((listas) {
      setState(() {
        _listasSalvas = listas;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de Compras'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_showSearchField ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchField = !_showSearchField;
              });
            },
          ),
        ],
      ),
      body: _listasSalvas.isEmpty
          ? const Center(child: Text('Nenhuma lista salva'))
          : Stack(
              children: [
                ListView.builder(
                  itemCount: _filteredListas.length,
                  itemBuilder: (context, index) {
                    final listaCompras = _filteredListas[index];
                    return Card(
                      child: ListTile(
                        title: Text(listaCompras.nome),
                        subtitle: Text('${listaCompras.itens.length} itens'),
                        onTap: () {
                          Navigator.pushNamed(context, 'Compras',
                              arguments: listaCompras);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _removerLista(listaCompras.nome);
                            setState(() {
                              _listasSalvas.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                Visibility(
                  visible: _showSearchField,
                  child: Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Buscar por item...",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  List<Lista> get _filteredListas {
    if (_searchText.isEmpty) {
      return _listasSalvas;
    } else {
      return _listasSalvas.where((lista) =>
          lista.itens.any((item) => item.nome.toLowerCase().contains(_searchText.toLowerCase()))).toList();
    }
  }

  Future<void> _removerLista(String listaId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lista_$listaId');
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
