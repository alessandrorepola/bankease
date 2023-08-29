import 'package:bankease/src.old/ui/screens/home_screen.dart';
import 'package:bankease/src.old/ui/screens/login_screen.dart';
import 'package:bankease/src.old/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<AuthViewModel>(context).userStream,
        builder: (context, snapshot) =>
            snapshot.hasData ? const HomeScreen() : const LoginScreen());
  }
}
