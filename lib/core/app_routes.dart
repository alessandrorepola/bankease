import 'package:bankease/features/requests/presentation/pages/add_request_page.dart';
import 'package:bankease/features/requests/presentation/pages/request_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankease/features/auth/presentation/pages/login_page.dart';
import 'package:bankease/features/auth/presentation/pages/register_page.dart';
import 'package:bankease/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  final FirebaseAuth firebaseAuth;

  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String requestDetails = '/request_details';
  static const String addRequestPage = '/add_request';

  String? initialRoute;

  AppRoutes(this.firebaseAuth) {
    if (firebaseAuth.currentUser == null) {
      initialRoute = login;
    } else {
      initialRoute = home;
    }
  }

  static get routes => {
        home: (context) => const HomePage(),
        login: (context) => const LoginPage(),
        register: (context) => const RegisterPage(),
        requestDetails: (context) => const RequestDetailsPage(),
        addRequestPage: (context) => AddRequestPage()
      };
}
