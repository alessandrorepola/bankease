// import 'package:bankease/firebase_options.dart';
// import 'package:bankease/features/app.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const App());
// }

import 'package:bankease/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bankease/core/app_routes.dart';
import 'package:bankease/core/app_theme.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Injection.setup();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: CustomNavigator.key,
        builder: (context, child) {
          return SafeArea(child: child!);
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('it'),
        ],
        initialRoute: Injection.getIt.get<AppRoutes>().initialRoute,
        locale: const Locale('it'),
        routes: AppRoutes.routes,
        title: 'BankEase',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
