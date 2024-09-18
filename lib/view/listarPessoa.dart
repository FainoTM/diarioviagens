import 'package:flutter/material.dart';

import '../service/databaseOperations.dart';

class ListarPessoas extends StatefulWidget {
  const ListarPessoas({super.key});

  @override
  State<ListarPessoas> createState() => _ListarPessoasState();
}

class _ListarPessoasState extends State<ListarPessoas> {


  final DatabaseOperationsFirebase _getCadastro = DatabaseOperationsFirebase();

  void _updatePessoa(String nome, int index){

    TextEditingController controller_nome = TextEditingController(text: nome);

    showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(labelText: 'Editar Nome'),
                    controller: controller_nome,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: () async{
                    DatabaseOperationsFirebase().updateRowFirebase(nome, controller_nome.text);
                      List<Map<String, dynamic>> updatedList = await _getCadastro.getUserFirebase();
                      setState(() {
                        updatedList;
                      });
                    Navigator.pop(context);
                  },
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent)),
                      child: Text('Salvar', style: TextStyle(color: Colors.white),) )
                ],
              ),
            ),
          ),
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Pessoas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getCadastro.getUserFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os dados.'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text(snapshot.data![index]['nome'], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                      leading: IconButton(icon: Icon(Icons.edit), color: Colors.greenAccent,
                        onPressed: (){
                          _updatePessoa(snapshot.data![index]['nome'], index);
                        },
                      ),
                      trailing: IconButton(icon: Icon(Icons.delete), color: Colors.redAccent,
                        onPressed: () async{
                          DatabaseOperationsFirebase().deleteRowFirebase(snapshot.data![index]['cpf']);
                          List<Map<String, dynamic>> updatedList = await _getCadastro.getUserFirebase();
                          setState(() {
                             updatedList;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Nenhum dado encontrado.'),
            );
          }
        },
      ),
    );
  }
}
