import 'package:dev/model/country_model.dart';
import 'package:dev/service/country_api.dart';
import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../service/databaseOperations.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CountryApi _getcountry = CountryApi();
  List<Country> _countrys = [];

  @override
  void initState() {
    super.initState();
    _fetchCountry();
  }

  Future<void> _fetchCountry() async {
    try {
      var country = await _getcountry.getCountrys();
      setState(() {
        _countrys = country;
      });
    } catch (e) {
      throw Exception('erro $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(
          'Página Inicial', style: TextStyle(color: Colors.white),
        ),
            toolbarHeight: 70,
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            actions: [
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white,),
                onPressed: (){
                  DatabaseOperationsFirebase().signOutUser();
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),]
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _countrys.isEmpty
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
                itemCount: _countrys.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Autor: ${_countrys[index].flag}'),
                                Text('Preço: ${_countrys[index].name}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}

/*
GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 1,
          children: List.generate(
            10,
            (index) {
              return Center(
                  child: Container(
                child: Row(
                  children: [
                    Text('imagem'),
                    Column(
                      children: [Text('title'), Text('Descrição $index')],
                    )
                  ],
                ),
              ));
            },
          )),*/