

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_routes.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;


  Future<void> infoCountryDB(String name, bool favorito, String flag, String region, String googleMaps, int population) async {
    final country = <String,dynamic>{
      "name": name,
      "flag": flag,
      "region": region,
      "googleMaps": googleMaps,
      "population": population,
      "favorito": favorito
    };
    await db.collection("country").add(country);
  }

  Future<List<Map<String, dynamic>>> getCountry() async {
    QuerySnapshot snapshot = await db.collection('country').where('favorito', isEqualTo: true).get();
    print(snapshot.docs);
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        "name": doc['name'],
        "flag": doc['flag'],
        "region": doc['region'],
        "googleMaps": doc['googleMaps'],
        "population": doc['population'],
        "favorito": doc['favorito']
      };
    }).toList();
  }

  Future<void> createUserWithEmailPass(context, String email, String senha) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if(credential.user != null){
        Navigator.pushNamed(context, AppRoutes.login);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if(e.code == 'channel-error') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas')));
      }
    } catch (e) {
      print(e);
    }

  }

  Future<void> signInWithEmailAndPassword(context, String email, String senha) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: senha
      );

      if(credential.user != null){
        Navigator.pushNamed(context, AppRoutes.homePage);
      }


    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if(e.code == 'channel-error'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não é permitido campos vazios')));
      } else if(e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('E-Mail Inválido')));
      } else if(e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credenciais Inválidas')));
      }

    }


  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}