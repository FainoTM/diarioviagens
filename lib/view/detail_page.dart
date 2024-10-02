import 'package:dev/service/databaseOperations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/country_model.dart';

class DetailPage extends StatefulWidget {
  final Country country;
  DetailPage({
    Key? key,
    required this.country,
  }) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.country.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.network(widget.country.flag),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.country.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.country.region,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Population: ${widget.country.population}',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  _launchUrl(widget.country.googleMaps);
                },
                child: Text('Ver pais no GoogleMaps'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  foregroundColor: Colors.white,
                  fixedSize: Size(240, 40),
                ),
                onPressed: () {
                  DatabaseOperationsFirebase().infoCountryDB(widget.country.name, true, widget.country.flag, widget.country.region, widget.country.googleMaps, widget.country.population);
                },
                label: Text('Adicionar aos Favoritos'),
                icon: Icon(
                  Icons.favorite,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possível abrir o link: $url';
  }
}