import 'package:dev/view/cadastroPessoa.dart';
import 'package:dev/view/forgotPage.dart';
import 'package:dev/view/home_page.dart';
import 'package:dev/view/listarPessoa.dart';
import 'package:dev/view/login.dart';
import 'package:dev/view/signUpPage.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes{
  static const homePage = '/homePage';
  static const cadastrarPessoa = '/pages/cadastroPessoa';
  static const listarPessoa = '/pages/listarPessoa';
  static const login = '/pages/login';
  static const signUp = '/pages/signUpPage';
  static const forgotPage = '/pages/forgotPage';
  static const webPage = '/components/webView';


  static Map<String, WidgetBuilder> define() {
    return {
      homePage: (BuildContext context) => HomePage(),
      cadastrarPessoa: (BuildContext context) => const CadastroPessoa(),
      listarPessoa: (BuildContext context) => const ListarPessoas(),
      login: (BuildContext context) => const LoginPage(),
      signUp: (BuildContext context) => const SignUpPage(),
      forgotPage: (BuildContext context) => ForgotPage(),
    };
  }
}