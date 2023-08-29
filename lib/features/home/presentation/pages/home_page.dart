import 'package:bankease/features/home/widgets/home_drawer.dart';
import 'package:bankease/features/profile/presentation/pages/profile_page.dart';
import 'package:bankease/features/requests/presentation/pages/requests_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          titleSpacing: -10,
          title: const Text('Home Page'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Account',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[RequestsPage(), ProfilePage()],
        ),
      ),
    );
  }
}
