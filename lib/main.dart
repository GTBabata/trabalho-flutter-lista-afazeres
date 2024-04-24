import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: const MeuApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();
  int _editingIndex = -1;

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _toggleStatus(int index) {
    setState(() {
      _tarefas[index].status = !_tarefas[index].status;
    });
  }

  void _editarTarefa(int index) {
    setState(() {
      _editingIndex = index;
      controlador.text = _tarefas[index].descricao;
    });
  }

  void _salvarEdicao() {
    if (controlador.text.isEmpty) {
      return;
    }
    setState(() {
      if (_editingIndex >= 0) {
        _tarefas[_editingIndex].descricao = controlador.text;
        _editingIndex = -1;
      } else {
        _tarefas.add(
          Tarefa(
            descricao: controlador.text,
            status: false,
          ),
        );
      }
      controlador.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        _tarefas[index].descricao,
                        style: TextStyle(
                          color: _tarefas[index].status
                              ? Colors.green
                              : Colors.red,
                          fontSize: 16,
                          decoration: _tarefas[index].status
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _tarefas[index].status,
                            onChanged: (bool? newValue) {
                              _toggleStatus(index);
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editarTarefa(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removerTarefa(index),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 1,
                    )
                  ],
                );
              },
            ),
          ),
          Divider(
            color: Colors.blue,
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: Colors
                                .blue, // This sets the focus color to blue
                          ),
                    ),
                    child: TextField(
                      controller: controlador,
                      cursorColor: Colors.blue, // Set the cursor color to blue
                      decoration: InputDecoration(
                        hintText: 'Nome da Tarefa',
                        hintStyle: TextStyle(
                            color:
                                Colors.blue), // Set the hint text color to blue
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Colors.blue), // Set the border color to blue
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors
                                  .blue), // Set the default enabled border color to blue
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors
                                  .blue), // Set the focused border color to blue
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 60)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.blue), // Set the background color to blue
                  ),
                  child: Text(
                    _editingIndex >= 0 ? 'Salvar Edição' : 'Adicionar Tarefa',
                    style: const TextStyle(
                      color: Colors
                          .white, // Set the text color to white for better contrast
                    ),
                  ),
                  onPressed: _salvarEdicao,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
