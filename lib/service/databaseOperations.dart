

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_routes.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;

  Future<void> createNewUserFirebase(String nome, String email, String cpf,
      String datanasc, String telefone) async {

    final user = <String, dynamic>{
      "nome": nome,
      "email": email,
      "cpf": cpf,
      "datanasc": datanasc,
      "telefone": telefone,
    };

    await db.collection("users").add(user).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<List<Map<String, dynamic>>> getUserFirebase() async {

    List<Map<String, dynamic>> userList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await db.collection("users").get();

    querySnapshot.docs.forEach((doc) {
      userList.add(doc.data());
    });

    return userList;

  }

  Future<void> deleteRowFirebase(String cpf) async {

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("users").where("cpf", isEqualTo: cpf).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs.first;

      await db.collection("users").doc(documentSnapshot.id).delete();

      print("Documento com CPF $cpf deletado com sucesso.");
    } else {
      print("Nenhum documento encontrado com o CPF $cpf.");
    }
  }

  Future<void> updateRowFirebase(String nomeatual, String nomenovo) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection(
        "users").where("nome", isEqualTo: nomeatual).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot
          .docs.first;

      await db.collection("users").doc(documentSnapshot.id).update(
          {"nome": nomenovo});
    }
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