
import 'package:dev/view/detail_page.dart';
import 'package:dev/view/list_favorite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/country_controller.dart';
import '../model/country_model.dart';

class HomePage extends StatelessWidget {
  final CountryController countryController = Get.put(CountryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visitar Países',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {
            Get.to(() => FavoritePage());
          }, icon: Icon(Icons.favorite))
        ],
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 50,
        centerTitle: true,
      ),
      body: Obx(() {
        if (countryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: ListView.builder(
                  itemCount: countryController.countrys.length,
                  itemBuilder: (context, index) {
                    Country country = countryController.countrys[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailPage(country: country));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          margin:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: ListTile(
                            title: Text(country.name),
                            subtitle: Text(country.population.toString()),
                            leading: Image.network(country.flag, width: 80,),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}