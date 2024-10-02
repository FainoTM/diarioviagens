import 'package:dev/service/databaseOperations.dart';
import 'package:dev/view/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  final DatabaseOperationsFirebase _countrys = DatabaseOperationsFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Países Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 50,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _countrys.getCountry(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.data.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final country = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    //Get.to(() => DetailPage(country: country));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      elevation: 8,
                      shadowColor: Colors.black,
                      child: ListTile(
                        title: Text(country['name']),
                        subtitle: Text(country['population'].toString()),
                        leading: Image.network(country['flag'], width: 80),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox(); // Retorna um SizedBox vazio caso não haja dados
        },
      ),
    );
  }
}
