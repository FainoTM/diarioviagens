import 'package:dev/view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //inicializa toda a pré estrutura necessária para funcionamento de apps de terceiros no caso firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.login,
    routes: AppRoutes.define(),
  ));
}

