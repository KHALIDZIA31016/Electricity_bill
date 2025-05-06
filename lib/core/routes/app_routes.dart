import 'package:electricity_app/bindings/home_bindings.dart';
import 'package:electricity_app/bindings/splash_bindings.dart';
import 'package:electricity_app/presentations/electric_companies/view/electric_companies_screen.dart';
import 'package:electricity_app/presentations/home_screen/view/home_view.dart';
import 'package:electricity_app/presentations/splash_screen/view/splash_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen';
  static const String electricCompanies = '/electricCompanies';
  static const String pesco = '/pesco';
  static const String lesco = '/lesco';
  static const String fesco = '/fesco';
  static const String kelectric = '/kelectric';
  static const String mepco = '/mepco';
  static const String qesco = '/qesco';


  // create the routes

  static final routes = [
    GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        binding: SplashBindings()
    ),
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
        binding: HomeBindings()
    ),
    GetPage(
      name: electricCompanies,
      page: () => ElectricCompaniesScreen(),
    ),

  ];
}