import 'package:dev/model/country_model.dart';
import 'package:dev/view/detail_page.dart';
import 'package:dev/view/forgotPage.dart';
import 'package:dev/view/home_page.dart';
import 'package:dev/view/login.dart';
import 'package:dev/view/signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const homePage = '/view/homePage';
  static const login = '/view/login';
  static const signUp = '/view/signUpPage';
  static const forgotPage = '/view/forgotPage';
  static const detailPage = '/view/detail_page';

  static List<GetPage> define() {
    return [
      GetPage(name: homePage, page: () => HomePage()),
      GetPage(name: login, page: () => LoginPage()),
      GetPage(name: signUp, page: () => SignUpPage()),
      GetPage(name: forgotPage, page: () => ForgotPage()),
      GetPage(
          name: detailPage,
          page: () {
            final Country country = Get.arguments;
            return DetailPage(country: country);
          })
    ];
  }
}
