  // ignore_for_file: camel_case_types

  import 'dart:convert';
  import 'package:json_annotation/json_annotation.dart';
  import 'package:flutter/material.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  //part 'compras_view.g.dart';

  class Compras_View extends StatefulWidget {
    const Compras_View({super.key});

    @override
    State<Compras_View> createState() => _Compras_ViewState();
  }

  @JsonSerializable()
  class Lista {
    final String nome;
    final List<Item> itens;

    Lista({
      required this.nome,
      required this.itens,
    });

    Map<String, dynamic> toJson() => {
      'nome': nome,
      'itens': itens.map((item) => item.toJson()).toList(),
    };
    factory Lista.fromJson(Map<String, dynamic> json) {
    final nome = json['nome'] as String;
    final itens = (json['itens'] as List).map((item) => Item.fromJson(item)).toList();
    return Lista(nome: nome, itens: itens);
  }
  }

  @JsonSerializable()
  class Item {
    final String nome;
    final int quantidade;
    bool comprado;

    Item({
      required this.nome,
      required this.quantidade,
      required this.comprado,
    });

    Map<String, dynamic> toJson() => {
      'nome': nome,
      'quantidade': quantidade,
      'comprado': comprado,
    };

    factory Item.fromJson(Map<String, dynamic> json) => Item(
      nome: json['nome'] as String,
      quantidade: json['quantidade'] as int,
      comprado: json['comprado'] as bool,
    );
  }

  class _Compras_ViewState extends State<Compras_View> {
    String _nomeLista = ''; // Variable to store the list name
    List<Item> _itens = [];
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _nomeListaController = TextEditingController();
    final TextEditingController _quantidadeController = TextEditingController();
    
    @override
    Widget build(BuildContext context) {

      final listaRecebida = ModalRoute.of(context)?.settings.arguments;

      if (listaRecebida is Lista) {
        _nomeLista = listaRecebida.nome; // Extrai o nome da lista
        final itens = listaRecebida.itens;
        // Update _itens with the extracted list
        _itens = itens;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(_nomeLista.isEmpty ? 'Lista de Compra' : _nomeLista),
          actions: [
            IconButton(
              onPressed: () async {
                if (_nomeLista.isNotEmpty && _itens.isNotEmpty) {
                  _saveList(_itens);
                  // Show success message (optional)
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, informe o nome da lista e adicione itens'),
                    ),
                  );
                  // Display error message (empty list name or items)
                }
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomeListaController,
                decoration: const InputDecoration(hintText: 'Nome da lista'),
                onChanged: (valor) => setState(() => _nomeLista = valor),
              ),
              const SizedBox(height: 10),
              // Campo para adicionar item
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(hintText: 'Nome do produto'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _quantidadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Quantidade'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      final nome = _nomeController.text;
                      final quantidade = int.parse(_quantidadeController.text);
                      _addItem(nome, quantidade);
                      _nomeController.clear();
                      _quantidadeController.clear();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Lista de itens
              Expanded(
                child: ListView.builder(
                  itemCount: _itens.length,
                  itemBuilder: (context, index) {
                    final item = _itens[index];
                    return ListTile(
                      leading: Checkbox(
                        value: item.comprado,
                        onChanged: (value) {
                          setState(() {
                            item.comprado = value!;
                          });
                        },
                      ),
                      title: Text(item.nome),
                      subtitle: Text('Quantidade: ${item.quantidade}'),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            _removeItem(item);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Total de itens
              Text(
                'Total de itens: ${_itens.length}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    void _addItem(String nome, int quantidade) {
      setState(() {
        _itens.add(Item(nome: nome, quantidade: quantidade, comprado: false));
      });
    }

    void _removeItem(Item item) {
      setState(() {
        _itens.remove(item);
      });
    }

  Future<void> _saveList(List<Item> itens) async {
    try {
      if (_nomeLista.isNotEmpty && itens.isNotEmpty) {
        // 1. Get SharedPreferences instance
        final prefs = await SharedPreferences.getInstance();

        // 2. Criar um novo objeto Lista com nome e itens
        final lista = Lista(nome: _nomeLista, itens: itens);

        // 3. Converter objeto Lista para string JSON
        final jsonLista = lista.toJson();

        // 4. Gerar um identificador único para a lista
        final idLista = _gerarNovoId();

        // 5. Salvar string JSON com o identificador da lista
        await prefs.setString('lista_$idLista', jsonEncode(jsonLista));

        // 6. Navegar para Listas_View com mensagem de sucesso
        Navigator.pushNamedAndRemoveUntil(
          context, 
          'App', 
          (route) => false,
        ).then((_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lista salva com sucesso')),
        ));
      } else {
        // Exibir mensagem de erro (lista vazia ou nome da lista)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, informe o nome da lista e adicione itens')),
        );
      }
    } catch (error) {
      // Gerenciar erros durante o processo de salvar
      print('Erro ao salvar lista: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar lista: $error')),
      );
    }
  }

  String _gerarNovoId() {
    // Implementar lógica para gerar ID único (timestamp, UUID, etc.)
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<List<Lista>> _recuperarListasSalvas() async {
    final prefs = await SharedPreferences.getInstance();
    final listaIds = prefs.getKeys().where((key) => key.startsWith('lista_'));
    final listas = await Future.wait(listaIds.map((id) async {
      final jsonLista = await prefs.getString(id);
      return Lista.fromJson(jsonDecode(jsonLista!));
    }));
    return listas;
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