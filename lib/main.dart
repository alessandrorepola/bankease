import 'package:bankease/core/services/local_notification_service/local_notification_service.dart';
import 'package:bankease/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bankease/core/app_routes.dart';
import 'package:bankease/core/app_theme.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Injection.setup();
  await Injection.getIt.get<LocalNotificationService>().init();
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
        // builder: (context, child) {
        //   return SafeArea(child: child!);
        // },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('it', 'IT'),
        ],
        initialRoute: Injection.getIt.get<AppRoutes>().initialRoute,
        locale: const Locale('it', 'IT'),
        routes: AppRoutes.routes,
        title: 'BankEase',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
