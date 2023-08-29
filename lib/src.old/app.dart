import 'package:bankease/src.old/ui/screens/add_request_screen.dart';
import 'package:bankease/src.old/ui/screens/home_screen.dart';
import 'package:bankease/src.old/ui/screens/login_screen.dart';
import 'package:bankease/src.old/ui/screens/registration_screen.dart';
import 'package:bankease/src.old/ui/widgets/widget_tree.dart';
import 'package:bankease/src.old/viewmodels/auth_viewmodel.dart';
import 'package:bankease/src.old/viewmodels/request_viewmodel.dart';
import 'package:bankease/src.old/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel()),
          ChangeNotifierProvider(create: (context) => RequestViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const WidgetTree(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            AddRequestScreen.routeName: (context) => const AddRequestScreen(),
            // SettingsScreen.routeName: (context) => SettingsScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegistrationScreen.routeName: (context) =>
                const RegistrationScreen(),
            // RequestDetailScreen.routeName: (context) => RequestDetailScreen(),
          },
        ));
  }
}
