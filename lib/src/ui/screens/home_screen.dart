import 'package:bankease/src/ui/screens/add_request_screen.dart';
import 'package:bankease/src/ui/widgets/main_drawer.dart';
import 'package:bankease/src/ui/widgets/requests.dart';
import 'package:bankease/src/viewmodels/auth_viewmodel.dart';
import 'package:bankease/src/viewmodels/request_viewmodel.dart';
import 'package:bankease/src/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthViewModel>(context, listen: false).uid!;
    Provider.of<UserViewModel>(context, listen: false).loadLoggedUser(uid);
    Provider.of<RequestViewModel>(context, listen: false).loadUserRequests(uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthViewModel>(context, listen: false)
                .signOut(context),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: const Requests(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddRequestScreen())),
          child: const Icon(Icons.add)),
    );
  }
}
