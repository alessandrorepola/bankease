import 'package:bankease/src.old/model/user.dart';
import 'package:bankease/src.old/ui/screens/add_request_screen.dart';
import 'package:bankease/src.old/ui/widgets/drawer_item.dart';
import 'package:bankease/src.old/viewmodels/auth_viewmodel.dart';
import 'package:bankease/src.old/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final User userInfo = Provider.of<UserViewModel>(context).user!;

    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            width: double.infinity,
            height: deviceHeight * 0.27,
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.black38,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userInfo.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${userInfo.name} ${userInfo.surname}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
              ),
              child: ListView(
                children: [
                  DrawerItem(
                    tileIcon: Icons.text_snippet,
                    tileText: 'Requests',
                    selectFn: () => Navigator.of(context).pop(),
                  ),
                  DrawerItem(
                    tileIcon: Icons.add_task,
                    tileText: 'Add Request',
                    selectFn: () => Navigator.of(context)
                        .popAndPushNamed(AddRequestScreen.routeName),
                  ),
                  const Divider(
                    height: 5,
                  ),
                  DrawerItem(
                      tileIcon: Icons.settings,
                      tileText: 'Settings',
                      selectFn: () {}),
                  DrawerItem(
                    tileIcon: Icons.logout,
                    tileText: 'Log out',
                    selectFn: () => Provider.of<AuthViewModel>(
                      context,
                      listen: false,
                    ).signOut(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
